require "spec_helper"

describe Chartmogul::Client do
  describe ".get_resource" do
    it "request the resources via :get" do
      stub_charmogul_ping_request(:get, nil)
      response = Chartmogul.get_resource "ping"
      expect(response.data).to eq("pong!")
    end
  end

  describe ".post_resource" do
    it "requests the resource via :post" do
      content = { massage: "message content" }
      stub_charmogul_ping_request(:post, content)

      expect(Chartmogul.post_resource("ping", content).data).to eq("pong!")
    end
  end

  describe ".patch" do
    it "requests the resource via :patch" do
      content = { message: "message content" }
      stub_charmogul_ping_request(:patch, content)

      expect(Chartmogul.patch_resource("ping", content).data).to eq("pong!")
    end
  end

  describe ".delete" do
    it "requests the resource via :delete" do
      stub_charmogul_ping_request(:delete, nil)
      response = Chartmogul.delete_resource("ping")

      expect(Chartmogul::Response.parse_json(response).data).to eq("pong!")
    end
  end

  def stub_charmogul_ping_request(method, content, end_point = "ping")
    stub_api_response(
      method, end_point, data: content, filename: "ping", status: 200
    )
  end
end
