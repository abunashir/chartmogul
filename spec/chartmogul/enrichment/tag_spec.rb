require "spec_helper"

describe Chartmogul::Enrichment::Tag do
  describe ".create" do
    context "when customer id and tags provided" do
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

    context "when email and tag provided" do
      it "adds a new tag to the customer" do
        tag_attributes = { email: "cusotmer@example.com", tag: "important" }

        stub_tag_create_api_with_email(tag_attributes)
        tags = Chartmogul::Enrichment::Tag.create(tag_attributes)

        expect(tags.tags.count).to eq(5)
        expect(tags.tags).to include("important")
      end
    end
  end

  describe ".remove" do
    it "removes the specified tag from customer" do
      tag_attributes = { customer_id: "customer_id_001", tag: "important" }

      stub_customer_tag_delete_api(tag_attributes)
      tags = Chartmogul::Enrichment::Tag.delete(tag_attributes)

      expect(tags.tags.count).to eq(4)
      expect(tags.tags).not_to include("important")
    end
  end
end
