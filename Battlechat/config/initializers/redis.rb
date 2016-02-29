require "redis"

# REDIS = Redis.new(Rails.application.config_for("redis/cable"))
REDIS = Redis.new(:host => 'localhost', :port => 6379)