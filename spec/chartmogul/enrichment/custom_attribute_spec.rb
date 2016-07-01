require "spec_helper"

describe Chartmogul::Enrichment::CustomAttribute do
  describe ".create" do
    context "when customer id and attribute provided" do
      it "adds a custom attribute to the customer" do
        custom_attrubute_hash = {
          customer_id: "customer_id_001", attribute: attribute
        }

        stub_custom_attribute_create_api(custom_attrubute_hash)
        custom_attribute = Chartmogul::Enrichment::CustomAttribute.create(
          custom_attrubute_hash
        )

        expect(custom_attribute.custom["CAC"]).not_to be_nil
        expect(custom_attribute.custom.channel).to eq("Facebook")
      end
    end

    describe "when email and custom attribute provided" do
      it "adds a custom attribute to the customer" do
        custom_attrubute_hash = {
          email: "customer@example.com", attribute: attribute
        }

        stub_custom_attribute_create_api_with_email(custom_attrubute_hash)
        custom_attribute = Chartmogul::Enrichment::CustomAttribute.create(
          custom_attrubute_hash
        )

        expect(custom_attribute.custom["CAC"]).not_to be_nil
        expect(custom_attribute.custom.channel).to eq("Facebook")
      end
    end
  end

  describe ".update" do
    it "updates customer's custom attributes" do
      custom_attrubute_hash = {
        customer_id: "customer_id_001", attribute: { channel: "Twitter" }
      }

      stub_custom_attribute_update_api(custom_attrubute_hash)
      custom_attribute = Chartmogul::Enrichment::CustomAttribute.update(
        custom_attrubute_hash
      )

      expect(custom_attribute.custom["CAC"]).not_to be_nil
      expect(custom_attribute.custom.channel).to eq("Twitter")
    end
  end

  def attribute
    {
      type: "String",
      key: "channel",
      value: "Facebook"
    }
  end
end
