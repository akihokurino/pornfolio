redis_config_file = File.join(Rails.root,'config','redis_store.yml')
raise "#{redis_store_config_file} is missing!" unless File.exists? redis_config_file
redis_config = YAML.load_file(redis_config_file)[Rails.env].symbolize_keys
redis_namespace = [redis_config[:namespace], Rails.env].join ':'
# Redis.current = Redis::Namespace.new(redis_namespace,
#                                     :redis => Redis.new(:host => redis_config[:host], :port => redis_config[:port]))
Redis.current = Redis.new(:host => redis_config[:host], :port => redis_config[:port])
Redis.current.ping