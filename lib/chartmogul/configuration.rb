module Chartmogul
  class Configuration
    attr_accessor :api_host, :response_type
    attr_accessor :account_token, :secret_key

    def initialize
      @api_host ||= "https://api.chartmogul.com/v1"
      @response_type ||= :object
    end

    def response_klass
      response_object || Hash
    end

    private

    def response_object
      if response_as_object?
        ResponseObject
      end
    end

    def response_as_object?
      response_type.to_s.casecmp("object") == 0
    end
  end

  def self.configure
    yield configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end
end
