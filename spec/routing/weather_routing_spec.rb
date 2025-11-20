# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherController, type: :routing do
  describe 'weather' do
    it 'root routes to #index' do
      expect(get: '/').to route_to('weather#index')
    end

    it 'weather index routes to #index' do
      expect(get: '/weather/index').to route_to('weather#index')
    end

    it 'routes to #retrieve' do
      expect(post: '/weather/retrieve').to route_to('weather#retrieve')
    end
  end
end
