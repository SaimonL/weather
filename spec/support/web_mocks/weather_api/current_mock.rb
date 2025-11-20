# frozen_string_literal: true

RSpec.shared_context 'mock api response from weather api' do
  let(:api_response_body) { file_fixture('weather_api/current_response.json').read }

  def mock_current_get_request(url)
    # "https://api.weatherapi.com/v1/current.json?key=...&q=06484"
    stub_request(:get, url).
      with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Ruby'
        }).
      to_return(status: 200, body: api_response_body, headers: { 'Content-Type' => 'application/json' })
  end
end
