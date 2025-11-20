# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherApiService::Base, type: :feature do
  # Location: spec/support/web_mocks/weather_api/error_response_mock.rb
  include_context 'mock api error responses from weather api'

  let(:service) { described_class.new }
  let(:base_url) { service.api_base_url }

  describe '#api_base_url' do
    subject { base_url }

    it { is_expected.to eq("https://api.weatherapi.com/#{WEATHER_API_VERSION}/") }
  end

  # 200 test are responsibility of the class that is using this method
  describe '#api_call' do
    subject { service.api_call(base_url) }

    context 'when response code is 404' do
      before { mock_404_response(base_url) }

      let(:message) { 'API Server was not found! Please check the URL and try again.' }

      it 'will raise an error with valid message' do
        expect { subject }.to raise_error(StandardError, message)
      end
    end

    context 'when response code is 500' do
      before { mock_500_response(base_url) }

      let(:message) { 'API Server encountered an internal error. Please try again later.' }

      it 'will raise an error with valid message' do
        expect { subject }.to raise_error(StandardError, message)
      end
    end

    context 'when response code is 403' do
      before { mock_403_response(base_url) }

      let(:message) { 'API key has exceeded calls per month quota.' }

      it 'will raise an error with valid message' do
        expect { subject }.to raise_error(StandardError, message)
      end
    end
  end
end
