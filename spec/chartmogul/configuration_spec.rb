require "spec_helper"

describe Chartmogul::Configuration do
  after { restore_default_config }

  context "when account token specified" do
    it "store it for further requests" do
      account_token = "secret_account_token"
      Chartmogul.configure { |config| config.account_token = account_token }

      expect(Chartmogul.configuration.account_token).to eq(account_token)
    end
  end

  context "when secret key specified" do
    it "store it for futther requests" do
      secret_key = "account_secret_key"
      Chartmogul.configure { |config| config.secret_key = secret_key }

      expect(Chartmogul.configuration.secret_key).to eq(secret_key)
    end
  end

  describe ".api_host" do
    context "when no api_host specified" do
      it "usages the default host" do
        default_api_host = "https://api.chartmogul.com/v1"
        expect(Chartmogul.configuration.api_host).to eq(default_api_host)
      end
    end

    context "when custom api_host is specified" do
      it "usages the custom host instead of deafult host" do
        custom_api_host = "https://custom-api-host.example.com"
        Chartmogul.configure { |config| config.api_host = custom_api_host }

        expect(Chartmogul.configuration.api_host).to eq(custom_api_host)
      end
    end
  end
end
