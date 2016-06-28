require "spec_helper"

describe Chartmogul::Enrichment::Tag do
  describe ".create" do
    it "adds a new tag to the customer" do
      tag_attributes = {
        customer_id: "customer_id_001", tag: "important"
      }

      stub_customer_tag_create_api(tag_attributes)
      tags = Chartmogul::Enrichment::Tag.create(
        tag_attributes
      )

      expect(tags.tags.count).to eq(5)
      expect(tags.tags).to include("important")
    end
  end
end
