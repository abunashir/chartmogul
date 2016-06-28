require "spec_helper"

describe Chartmogul::Enrichment::Attribute do
  describe ".list" do
    it "retrieves a given customer attributes" do
      customer_id = "customer_id_001"

      stub_customer_attribute_list_api(customer_id)
      attributes = Chartmogul::Enrichment::Attribute.list(
        customer_id: customer_id
      )

      expect(attributes.attributes.custom[:CAC]).to eq(213)
      expect(attributes.attributes.stripe[:uid]).not_to be_nil
      expect(attributes.attributes.tags).to eq(%w(engage discountable))
    end
  end
end
