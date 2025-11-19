module WeatherApiService
  class Current < Base
    def initialize(zip_code)
      @zip_code = zip_code
    end

    def location
      get_weather["location"]
    end

    def weather_details
      get_weather["current"]
    end

    def get_weather
      @get_weather ||= api_call(api_call_url(@zip_code))
    end

    # NOTE: This 3rd party service requires the api key to be exposed in the url.
    # Unfortunately they do not accept api key in any other way.
    def api_call_url(zip_code)
      [ api_base_url, "current.json?key=#{WEATHER_API_KEY}&q=", zip_code ].join
    end
  end
end
