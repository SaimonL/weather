WEATHER_API_KEY = ENV["WEATHER_API_KEY"]
WEATHER_API_VERSION = "v1".freeze

if WEATHER_API_KEY.nil? || WEATHER_API_KEY.empty?
  raise "Please specify the WEATHER_API_KEY in the environment variable"
end
