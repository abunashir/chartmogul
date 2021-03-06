require "spec_helper"

describe Chartmogul::Import::Customer do
  describe ".create" do
    it "creates a new customer" do
      customer_attributes = {
        name: "Adam Smith",
        external_id: "customer_001",
        data_source_uuid: "ds_uuid_001",
        email: "adam@smith.com",
        city: "New York",
        state: "NY",
        zip: "ABC123",
        country: "US",
        company: "ChartMogul"
      }

      stub_customer_create_api(customer_attributes)
      customer = Chartmogul::Import::Customer.create customer_attributes

      expect(customer.uuid).not_to be_nil
      expect(customer.name).to eq(customer_attributes[:name])
      expect(customer.company).to eq(customer_attributes[:company])
    end
  end

  describe ".list" do
    it "lists imported customers" do
      listing_options = { page: 1, per_page: 3 }
      stub_customer_list_api(listing_options)
      customers = Chartmogul::Import::Customer.list(listing_options)

      expect(customers.current_page).to eq(1)
      expect(customers.customers.count).to eq(3)
      expect(customers.customers.first.uuid).not_to be_nil
    end
  end

  describe ".delete" do
    it "delete a specifeid customer" do
      customer_uuid = "customer_001_uuid"
      stub_customer_delete_api(uuid: customer_uuid)

      expect do
        Chartmogul::Import::Customer.delete(uuid: customer_uuid)
      end.not_to raise_error
    end
  end
end
