require "spec_helper"

describe Chartmogul::Response do
  describe ".parse_json" do
    context "when response type set to hash" do
      it "parses the content to Hash" do
        response = api_response_for(type: :hash)

        expect(response.class).to eq(Hash)
        expect(response["data"]).to eq("pong!")
      end
    end

    context "when response type set to object" do
      it "parses the content to ResponseObject" do
        response = api_response_for(type: :object)

        expect(response.data).to eq("pong!")
        expect(response.class).to eq(Chartmogul::ResponseObject)
      end
    end
  end

  def api_response_for(type:)
    Chartmogul.configuration.response_type = type
    json_content = File.read "./spec/fixtures/ping.json"

    Chartmogul::Response.parse_json(json_content)
  end
end
