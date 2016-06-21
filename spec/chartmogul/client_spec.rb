require "spec_helper"

describe Chartmogul::Client do
  describe ".get_resource" do
    it "request the resources via get" do
      stub_authentication_api
      response = Chartmogul.get_resource "ping"
      expect(response.data).to eq("pong!")
    end
  end
end
