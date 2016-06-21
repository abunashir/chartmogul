module FakeChartmogulApi
  def stub_authentication_api
    stub_api_response("ping", :get, filename: "authentication", status: 200)
  end

  private

  def stub_api_response(end_point, method, filename:, status: 200)
    stub_request(method, api_path(end_point)).
      with(headers: api_request_header).
      to_return(response_with(filename: filename, status: status))
  end

  def api_path(end_point)
    [Chartmogul.configuration.api_host, end_point].join("/")
  end

  def api_request_header
    {
      "Accept" => "*/*; q=0.5, application/xml",
      "Accept-Encoding" => "gzip, deflate",
      "Authorization" => "Basic QUNDT1VOVF9UT0tFTjpBQ0NPVU5UX1NFQ1JFVF9LRVk=",
      "User-Agent" => "Ruby"
    }
  end

  def response_with(filename:, status:)
    { body: fixture_file(filename), status: status }
  end

  def fixture_file(filename)
    File.read "./spec/fixtures/#{filename}.json"
  end
end
