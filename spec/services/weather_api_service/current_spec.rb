# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherApiService::Current, type: :feature do
  # Location: spec/support/web_mocks/weather_api/current_mock.rb
  # Don't stub the method that calls the API.
  # Stub the network communication using webmock.
  # This allows you to test and debug in deeper level.
  include_context 'mock api response from weather api'

  let(:service) { described_class.new(zip_code) }
  let(:zip_code) { '06484' }

  describe '#api_call_url' do
    subject { service.api_call_url(zip_code) }

    it { is_expected.to eq("https://api.weatherapi.com/#{WEATHER_API_VERSION}/current.json?key=#{WEATHER_API_KEY}&q=#{zip_code}") }
  end

  describe '#cache_key' do
    subject { service.cache_key }

    it { is_expected.to eq("current_weather_#{zip_code}") }
  end

  describe '#cached_data' do
    subject { service.cached_data }

    it { is_expected.to be_nil }
  end

  describe '#get_weather' do
    subject { service.get_weather }

    let(:url) { service.api_call_url(zip_code) }

    before { mock_current_get_response(url) }

    its(:size)    { should eq(2) }
    its(:keys)    { is_expected.to eq(%w[location current]) }
  end

  describe '#location_details' do
    subject { service.location_details }

    let(:url) { service.api_call_url(zip_code) }

    before { mock_current_get_response(url) }

    its([ 'name' ])       { is_expected.to eq('Shelton') }
    its([ 'region' ])     { is_expected.to eq('Connecticut') }
    its([ 'country' ])    { is_expected.to eq('USA') }
    its([ 'tz_id' ])      { is_expected.to eq('America/New_York') }
    its([ 'localtime' ])  { is_expected.to eq('2025-11-19 07:26') }
  end

  describe '#weather_details' do
    subject { service.weather_details }

    let(:url) { service.api_call_url(zip_code) }

    before { mock_current_get_response(url) }

    # Only test what we actually use. Otherwise its too much noise
    its([ 'last_updated' ])   { is_expected.to eq('2025-11-19 07:15') }
    its([ 'temp_c' ])         { is_expected.to eq(2.8) }
    its([ 'feelslike_c' ])    { is_expected.to eq(1.6) }
    its([ 'temp_f' ])         { is_expected.to eq(37) }
    its([ 'feelslike_f' ])    { is_expected.to eq(34.8) }
    its(%w[condition text])   { is_expected.to eq('Overcast') }

    its([ 'wind_mph' ])       { is_expected.to eq(3.1) }
    its([ 'wind_kph' ])       { is_expected.to eq(5) }
    its([ 'wind_dir' ])       { is_expected.to eq('WNW') }

    its([ 'humidity' ])       { is_expected.to eq(72) }
    its([ 'cloud' ])          { is_expected.to eq(100) }
    its([ 'dewpoint_c' ])     { is_expected.to eq(-3.6) }
    its([ 'dewpoint_f' ])     { is_expected.to eq(25.6) }
    its([ 'uv' ])             { is_expected.to eq(0) }
  end
end
