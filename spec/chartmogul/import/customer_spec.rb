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
end
