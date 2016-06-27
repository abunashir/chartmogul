require "spec_helper"

describe Chartmogul::Response do
  describe ".parse_json" do
    it "parse json response" do
      json_content = File.read "./spec/fixtures/ping.json"
      response_object = Chartmogul::Response.parse_json(json_content)

      expect(response_object.data).to eq("pong!")
    end
  end
end
