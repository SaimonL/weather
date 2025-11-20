# frozen_string_literal: true

RSpec.shared_context 'mock api error responses from weather api' do
  def mock_400_response(url)
    stub_request(:get, url).
      with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Ruby'
        }).
      to_return(
        status: 400,
        body: '{ "error": { "message": "No location found matching parameter q", "code": 1006 } }',
        headers: { 'Content-Type' => 'application/json' }
      )
  end

  def mock_403_response(url)
    stub_request(:get, url).
      with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Ruby'
        }).
      to_return(
        status: 403,
        body: '{ "error": { "message": "API key has exceeded calls per month quota.", "code": 2007 } }',
        headers: { 'Content-Type' => 'application/json' }
      )
  end

  def mock_404_response(url)
    stub_request(:get, url).
      with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Ruby'
        }).
      to_return(status: 404, body: '', headers: {})
  end

  def mock_500_response(url)
    stub_request(:get, url).
      with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Ruby'
        }).
      to_return(status: 500, body: '', headers: {})
  end
end
