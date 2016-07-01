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
      stub_charmogul_ping_request(:post, content_body)
      expect(Chartmogul.post_resource("ping", content_body).data).to eq("pong!")
    end
  end

  describe ".put_resource" do
    it "requests the resource via :put" do
      stub_charmogul_ping_request(:put, content_body)
      expect(Chartmogul.put_resource("ping", content_body).data).to eq("pong!")
    end
  end

  describe ".patch_resource" do
    it "requests the resource via :patch" do
      stub_charmogul_ping_request(:patch, content_body)

      expect(
        Chartmogul.patch_resource("ping", content_body).data
      ).to eq("pong!")
    end
  end

  describe ".delete_resource" do
    it "requests the resource via :delete" do
      stub_charmogul_ping_request(:delete, nil)
      response = Chartmogul.delete_resource("ping")

      expect(Chartmogul::Response.parse_json(response).data).to eq("pong!")
    end
  end

  def content_body
    { message: "message content" }
  end

  def stub_charmogul_ping_request(method, content, end_point = "ping")
    stub_api_response(
      method, end_point, data: content, filename: "ping", status: 200
    )
  end
end
