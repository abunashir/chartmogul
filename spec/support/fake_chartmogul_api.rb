module FakeChartmogulApi
  def stub_authentication_api
    stub_api_response(:get, "ping", filename: "authentication", status: 200)
  end

  def stub_data_source_create_api(data_source)
    stub_api_response(
      :post,
      "import/data_sources",
      data: data_source,
      filename: "datasource_created",
      status: 201
    )
  end

  def stub_data_source_list_api
    stub_api_response(
      :get, "import/data_sources", filename: "datasource_list", status: 200
    )
  end

  private

  def stub_api_response(method, end_point, filename:, status: 200, data: nil)
    stub_request(method, api_end_point(end_point)).
      with(api_request_headers(data: data)).
      to_return(response_with(filename: filename, status: status))
  end

  def api_end_point(end_point)
    [Chartmogul.configuration.api_host, end_point].join("/")
  end

  def api_request_headers(data:)
    Hash.new.tap do |request_headers|
      request_headers[:headers] = authentication_header

      unless data.nil?
        request_headers[:body] = data.to_json
      end
    end
  end

  def authentication_header
    {
      "Authorization" => "Basic QUNDT1VOVF9UT0tFTjpBQ0NPVU5UX1NFQ1JFVF9LRVk=",
      "Content-Type" => "application/json"
    }
  end

  def response_with(filename:, status:)
    { body: fixture_file(filename), status: status }
  end

  def fixture_file(filename)
    File.read "./spec/fixtures/#{filename}.json"
  end
end