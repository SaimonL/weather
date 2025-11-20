# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'weather/index', type: :view do
  describe 'initial visit' do
    before { render }

    it 'renders header' do
      expect(rendered).to include('<h1>Weather Report</h1>')
    end

    it 'renders instructions' do
      expect(rendered).to match /Just enter your zip code below and get current weather details/
    end

    it 'has input weather form' do
      assert_select 'form[action=?][method=?]', '/weather/retrieve', 'post' do
        assert_select 'label[for=?]', 'zip_code',   count: 1
        assert_select 'input[type=?]', 'text',      count: 1
        assert_select 'input[name=?]', 'zip_code',  count: 1
        assert_select 'input[type=?]', 'submit',    count: 1
        assert_select 'input[name=?]', 'commit',    count: 1
      end
    end

  end

  describe 'after searching weather' do
    include_context 'mock api response from weather api'

    before do
      assign(:is_cached_data, true)
      assign(:location_details, api_response_json['location'])
      assign(:weather_details, api_response_json['current'])
    end

    subject { rendered }

    context 'with address section' do
      before { render }

      address_fields = [
        { label: 'City', value: 'Shelton' },
        { label: 'Region', value: 'Connecticut' },
        { label: 'Country', value: 'USA' },
        { label: 'Time', value: '2025-11-19 07:26' },
        { label: 'Time Zone', value: 'America/New_York' }
      ]

      address_fields.each do |field|
        it { is_expected.to include('<dt class="col-sm-3">' + field[:label] + '</dt>') }
        it { is_expected.to include('<dd class="col-sm-9">' + field[:value] + '</dd>') }
      end
    end

    context 'with forecast section' do
      before { render }

      address_fields = [
        { label: 'Last Radar Update', value: '2025-11-19 07:15' },
        { label: 'Temp C &deg;', value: '2.8' },
        { label: 'Feels like C &deg;', value: '1.6' },
        { label: 'Temp F &deg;', value: '37' },
        { label: 'Feels like F &deg;', value: '34.8' },
        { label: 'Condition', value: 'Overcast' },
        { label: 'Wind MPH / KPH', value: '3.1 / 5' },
        { label: 'Wind Direction', value: 'WNW' },
        { label: 'Humidity', value: '72' },
        { label: 'Percentage Cloud', value: '100' },
        { label: 'Dew Point C &deg;', value: '-3.6' },
        { label: 'Dew Point F &deg;', value: '25.6' },
        { label: 'UV Index', value: '0' }
      ]

      address_fields.each do |field|
        it { is_expected.to include('<dt class="col-sm-3">' + field[:label] + '</dt>') }
        it { is_expected.to include('<dd class="col-sm-9">' + field[:value] + '</dd>') }
      end
    end

    context 'when api data is cached' do
      before { render }

      it { is_expected.to include("Shelton, Connecticut\n(Cached Data)") }
    end

    context 'when api data is not cached' do
      before do
        assign(:is_cached_data, false)
        render
      end

      it { is_expected.to include("Shelton, Connecticut\n(Live Data)") }
    end
  end
end
