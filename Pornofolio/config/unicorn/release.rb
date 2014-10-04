require 'yaml'
require 'redis'

proj_root_dir = File.expand_path("../../../", __FILE__)
worker_processes 4
timeout 15
preload_app true
listen      "#{proj_root_dir}/tmp/sockets/unicorn.sock"
pid         "#{proj_root_dir}/tmp/pids/unicorn.pid"
stderr_path "#{proj_root_dir}/log/unicorn.log"
stdout_path "#{proj_root_dir}/log/unicorn.log"


redis_config_file = File.join(proj_root_dir,'config','redis_store.yml')
raise "#{redis_store_config_file} is missing!" unless File.exists? redis_config_file
rails_env       = ENV['RAILS_ENV']
redis_config    = YAML.load_file(redis_config_file)[rails_env]



# graceful restart用の設定 (Masterプロセスがシームレスに切り替わる)
before_fork do |server, worker|
  old_pid = "#{server.config[:pid]}.oldbin"
  # oldプロセスがいたら終了する
  if File.exists?(old_pid) && old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end

  Redis.current.quit if defined?(Redis)
end


after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
  Redis.current = Redis.new(:host => redis_config[:host], :port => redis_config[:port]) if defined?(Redis)
  Sidekiq.configure_client do |config|
    config.redis = { :url => "redis://#{redis_config['host']}:#{redis_config['port']}",
                     :namespace => "sidekiq" }
  end
end