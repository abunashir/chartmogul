module Chartmogul
  class Configuration
    attr_accessor :api_host, :account_token, :secret_key

    def initialize
      @api_host ||= "https://api.chartmogul.com/v1"
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
