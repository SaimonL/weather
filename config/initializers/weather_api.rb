WEATHER_API_KEY = ENV["WEATHER_API_KEY"]
WEATHER_API_VERSION = "v1".freeze
WEATHER_CACHE_TTL_MINUTES = 30.minutes.freeze

if !Rails.env.test && (WEATHER_API_KEY.nil? || WEATHER_API_KEY.empty?)
  raise "Please specify the WEATHER_API_KEY in the environment variable"
end
