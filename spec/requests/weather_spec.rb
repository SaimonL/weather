# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/weather', type: :request do
  let(:api) { WeatherApiService::Current.new(zip_code) }
  let(:zip_code) { '06484' }

  describe 'GET /weather/index' do
    it 'renders a successful response' do
      get weather_index_path
      expect(response).to be_successful
    end
  end

  describe 'POST /weather/retrieve' do
    # Location: spec/support/web_mocks/weather_api/
    include_context 'mock api response from weather api'
    include_context 'mock api error responses from weather api'

    let(:url) { api.api_call_url(zip_code) }
    let(:valid_attribute) { { zip_code: } }
    let(:invalid_attribute) { { zip_code: '' } }
    let(:location_notfound_attribute) { { zip_code: } }

    before { mock_current_get_response(url) }

    context 'with valid params' do
      before { post(weather_retrieve_path, params: valid_attribute) }

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'not redirect and render index page' do
        expect(response).to render_template(:index)
      end

      it 'assigns valid zip_code' do
        expect(assigns(:zip_code)).to eq(zip_code)
      end

      # Full values are tested in: spec/services/weather_api_service/current_spec.rb
      it 'assigns valid location_details' do
        location_details = assigns(:location_details)
        expect(location_details.keys)
          .to eq(%w[name region country lat lon tz_id localtime_epoch localtime])
      end

      # Full values are tested in: spec/services/weather_api_service/current_spec.rb
      it 'assigns valid weather_details' do
        weather_details = assigns(:weather_details)

        expect(weather_details.keys)
          .to eq(%w[last_updated_epoch last_updated temp_c temp_f is_day condition wind_mph wind_kph wind_degree
                    wind_dir pressure_mb pressure_in precip_mm precip_in humidity cloud feelslike_c feelslike_f
                    windchill_c windchill_f heatindex_c heatindex_f dewpoint_c dewpoint_f vis_km vis_miles uv
                    gust_mph gust_kph short_rad diff_rad dni gti])
      end
    end

    context 'with invalid params' do
      before { post(weather_retrieve_path, params: invalid_attribute) }

      it 'returns a successful response' do
        expect(response).not_to be_successful
      end

      it 'redirect to weather index page with a notice' do
        expect(response).to redirect_to(weather_index_path)
        expect(flash[:notice]).to eq('Please enter a valid zip code')
      end
    end

    context 'location not found' do
      let(:zip_code) { 'aabbcc' }

      before do
        mock_400_response(url)
        post(weather_retrieve_path, params: location_notfound_attribute)
      end

      it 'redirect to weather index page with an alert' do
        expect(response).to redirect_to(weather_index_path)
        expect(flash[:alert])
          .to eq('An error has occurred when searching aabbcc, please try again later. No location found matching parameter q')
      end
    end
  end
end
