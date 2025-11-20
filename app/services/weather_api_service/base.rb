module WeatherApiService
  require "httparty"

  class Base
    # This 3rd party service does all API calls via GET request
    # and all the params are passed via url
    def api_call(url)
      response = HTTParty.get(url)

      case response.code
        when 200
          response.as_json
        when 404
          raise "API Server was not found! Please check the URL and try again."
        when 500
          raise "API Server encountered an internal error. Please try again later."
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
