require "spec_helper"

describe Chartmogul::Enrichment::CustomAttribute do
  describe ".create" do
    context "when customer id and attribute provided" do
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

    describe "when email and custom attribute provided" do
      it "adds a custom attribute to the customer" do
        email = "customer@example.com"
        attribute = {
          type: "String",
          key: "channel",
          value: "Facebook"
        }

        stub_custom_attribute_create_api_with_email(
          email: email, attribute: attribute
        )

        custom_attribute = Chartmogul::Enrichment::CustomAttribute.create(
          email: email, attribute: attribute
        )

        expect(custom_attribute.custom["CAC"]).not_to be_nil
        expect(custom_attribute.custom.channel).to eq("Facebook")
      end
    end
  end
end
