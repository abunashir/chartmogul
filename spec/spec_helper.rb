require "webmock/rspec"
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "chartmogul"

Dir["./spec/support/**/*.rb"].sort.each { |file| require file }

RSpec.configure do |config|
  config.before :suite do
    config.include FakeChartmogulApi

    config.before :all do
      Chartmogul.configure do |chartmogul_config|
        chartmogul_config.account_token = "ACCOUNT_TOKEN"
        chartmogul_config.secret_key = "ACCOUNT_SECRET_KEY"
      end
    end
  end
end

def restore_default_config
  Chartmogul.configuration = nil
  Chartmogul.configure {}
end
