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
      resources[end_point].get
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
end
