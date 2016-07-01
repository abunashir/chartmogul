require "rest-client"
require "chartmogul/response"
require "chartmogul/configuration"

module Chartmogul
  class Client
    attr_reader :end_point, :http_method, :attributes, :headers

    def initialize(end_point, http_method, headers: {}, **attributes)
      @end_point = end_point
      @http_method = http_method
      @headers = headers
      @attributes = attributes
    end

    def execute
      Chartmogul::Response.parse_json(execute_request)
    end

    private

    def execute_request
      RestClient::Request.execute(
        method: http_method,
        url: api_end_point,
        payload: attributes.to_json,
        headers: additional_headers,
        user: Chartmogul.configuration.account_token,
        password: Chartmogul.configuration.secret_key
      )
    end

    def api_end_point
      [Chartmogul.configuration.api_host, end_point].join("/")
    end

    def additional_headers
      headers.merge(content_type: :json)
    end
  end

  def self.get_resource(end_point, attributes = {})
    Client.new(end_point, :get, headers: { params: attributes }).execute
  end

  def self.post_resource(end_point, attributes)
    Client.new(end_point, :post, attributes).execute
  end

  def self.put_resource(end_point, attributes)
    Client.new(end_point, :put, attributes).execute
  end

  def self.patch_resource(end_point, attributes)
    Client.new(end_point, :patch, attributes).execute
  end

  def self.delete_resource(end_point, attributes = {})
    Client.new(end_point, :delete, attributes).execute
  end
end
