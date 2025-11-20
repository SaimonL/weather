module WeatherApiService
  require "httparty"

  class Base
    # This 3rd party service does all API calls via GET request
    # and all the params are passed via url
    def api_call(url)
      response = HTTParty.get(url)

      if response.code == 200
        response.as_json
      else
        error = response.as_json["error"]
        raise error["message"]
      end
    end

    def api_base_url
      "https://api.weatherapi.com/#{WEATHER_API_VERSION}/"
    end
  end
end
