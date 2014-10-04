require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == ["admin", "adultproject2013"]
end

redis_config_file = File.join(Rails.root,'config','redis_store.yml')
raise "#{redis_store_config_file} is missing!" unless File.exists? redis_config_file
redis_config = YAML.load_file(redis_config_file)[Rails.env].symbolize_keys
Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{redis_config[:host]}:#{redis_config[:port]}", namespace: "sidekiq" }
end
Sidekiq.configure_client do |config|
  config.redis = { :url => "redis://#{redis_config[:host]}:#{redis_config[:port]}",
                   :namespace => "sidekiq"
  }
end