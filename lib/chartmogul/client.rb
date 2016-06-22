require "rest-client"
require "chartmogul/response"
require "chartmogul/configuration"

module Chartmogul
  class Client
    attr_reader :end_point, :attributes

    def initialize(end_point, attributes = {})
      @end_point = end_point
      @attributes = attributes
    end

    def get
      resources[end_point].get content_type: :json
    end

    def post
      resources[end_point].post attributes.to_json, content_type: :json
    end

    private

    def resources
      @resources ||= RestClient::Resource.new(
        Chartmogul.configuration.api_host,
        Chartmogul.configuration.account_token,
        Chartmogul.configuration.secret_key
      )
    end
  end

  def self.get_resource(end_point)
    Chartmogul::Response.parse_json(
      Client.new(end_point).get
    )
  end

  def self.post_resource(end_point, attributes)
    Chartmogul::Response.parse_json(
      Client.new(end_point, attributes).post
    )
  end
end