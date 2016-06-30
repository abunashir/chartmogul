require "spec_helper"

describe Chartmogul::Enrichment::CustomAttribute do
  describe ".create" do
    it "adds a custom attribute to the customer" do
      customer_id = "customer_id_001"
      attribute = {
        type: "String",
        key: "channel",
        value: "Facebook"
      }

      stub_custom_attribute_create_api(
        customer_id: customer_id, attribute: attribute
      )

      custom_attribute = Chartmogul::Enrichment::CustomAttribute.create(
        customer_id: customer_id, attribute: attribute
      )

      expect(custom_attribute.custom["CAC"]).not_to be_nil
      expect(custom_attribute.custom.channel).to eq("Facebook")
    end
  end
end
