class WeatherController < ApplicationController
  before_action :set_zip_code

  def index
  end

  def retrieve
    return redirect_to weather_index_path, notice: "Please enter a valid zip code" if @zip_code.blank?

    # Even though we ask for zip code, it can also take city name, Latitude and Longitude, IP address ...
    ws = weather_service(@zip_code)
    @is_cached_data = ws.cached_data.present?

    begin
      @location_details = ws.location_details
      @weather_details = ws.weather_details
    rescue StandardError => e
      # TODO: In production you don't want to expose `e.message` Instead report it to Sentry.IO or DataDog
      return redirect_to weather_index_path,
                         alert: "An error has occurred when searching #{@zip_code}, please try again later. #{e.message}"
    end

    render :index
  end

  private

    def weather_params
      params.permit(:zip_code)
    end

    def set_zip_code
      @zip_code = weather_params[:zip_code]&.strip
      @zip_code = @zip_code[0..100].to_letters_and_numbers if @zip_code # Prevent large string attack
    end

    def weather_service(zip_code)
      @weather_service ||= WeatherApiService::Current.new(zip_code)
    end
end
