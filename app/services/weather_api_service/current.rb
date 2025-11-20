module WeatherApiService
  class Current < Base
    def initialize(zip_code)
      @zip_code = zip_code
    end

    def location_details
      get_weather["location"]
    end

    def weather_details
      get_weather["current"]
    end

    # Always cache API response. It gives developer more flexibility.
    def get_weather
      # Auto caches the data if not found in cache.
      @get_weather ||=
        Rails.cache.fetch(cache_key, expires_in: WEATHER_CACHE_TTL_MINUTES) do
          api_call(api_call_url(@zip_code))
        end
    end

    # NOTE: This 3rd party service requires the api key to be exposed in the url.
    # Unfortunately they do not accept api key in any other way.
    def api_call_url(zip_code)
      [ api_base_url, "current.json?key=#{WEATHER_API_KEY}&q=", zip_code ].join
    end

    def cache_key
      [ :current, :weather,  @zip_code ].join("_")
    end

    def cached_data
      Rails.cache.fetch(cache_key)
    end
  end
end
