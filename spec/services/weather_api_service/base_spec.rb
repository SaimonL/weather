# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherApiService::Base, type: :feature do
  let(:service) { described_class.new }

  describe '#api_base_url' do
    subject { service.api_base_url }

    it { is_expected.to eq("https://api.weatherapi.com/#{WEATHER_API_VERSION}/") }
  end
end
