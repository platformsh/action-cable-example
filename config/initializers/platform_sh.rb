require 'base64'
require 'json'
relationships = JSON.parse(Base64.decode64(ENV['PLATFORM_RELATIONSHIPS']))

return unless Rails.env.production?
@config = PlatformSH::config
redis_host = relationships.fetch('cache').first.fetch('host')
redis_port = relationships.fetch('cache').first.fetch('port')

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{redis_host}:#{redis_port}/2" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{redis_host}:#{redis_port}/2" }
end

Rails.application.configure do |config|
  config.action_cable.url = "redis://#{redis_host}:#{redis_port}/1"
end
