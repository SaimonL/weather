module WeatherApiService
  class ApiServiceNotFound < StandardError; end
  class ApiServiceInternalError < StandardError; end

  class MissingApiKeyError < StandardError; end
  class InvalidApiKeyError < StandardError; end
  class ApiKeyLimitReachedError < StandardError; end
  class AccountSubscriptionError < StandardError; end

  class InvalidRequestError < StandardError; end
  class LocationNotFoundError < StandardError; end

  class ApiErrors
    def initialize(response)
      @response = response
    end

    def process
      raise ApiServiceInternalError if @response.code == 500
      raise ApiServiceNotFound("Please check the URL and try again.") if @response.code == 404

      error = @response.as_json["error"]
      code = error["code"]
      message = error["message"]

      process_400_response(code:, message:) if @response.code == 400
      process_401_response(code:, message:) if @response.code == 401
      process_403_response(code:, message:) if @response.code == 403
    end

    def process_400_response(code:, message:)
      case code
        when 1003, 1005
          raise InvalidRequestError(message)
        when 1006
          raise LocationNotFoundError(message)
        when 9999
          raise ApiServiceInternalError(message)
        else
          raise "Unknown Error: #{message}"
      end
    end

    def process_401_response(code:, message:)
      case code
        when 1002
          raise MissingApiKeyError(message)
        when 2006
          raise InvalidApiKeyError(message)
        else
          raise "Unknown Error: #{message}"
      end
    end

    def process_403_response(code:, message:)
      case code
        when 2007
          raise ApiKeyLimitReachedError(message)
        when 2009
          raise AccountSubscriptionError(message)
        else
          raise "Unknown Error: #{message}"
      end
    end
  end
end
