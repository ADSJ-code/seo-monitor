default_redis_url = 'redis://localhost:6379'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', default_redis_url) }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', default_redis_url) }
end