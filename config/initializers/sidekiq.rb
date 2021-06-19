# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.redis = { :url => ENV.fetch('REDISCLOUD_URL') { 'redis://localhost:6379/1' } }
end

Sidekiq.configure_client do |config|
  config.redis = { :url => ENV.fetch('REDISCLOUD_URL') { 'redis://localhost:6379/1' } }
end

Sidekiq.default_worker_options['retry'] = 12
