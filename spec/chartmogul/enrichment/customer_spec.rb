require "spec_helper"

describe Chartmogul::Enrichment::Customer do
  describe ".find" do
    it "retrieves a customer details" do
      customer_id = "customer_id_001"

      stub_customer_find_api(customer_id)
      customer = Chartmogul::Enrichment::Customer.find(customer_id)

      expect(customer.id).to eq(customer_id)
      expect(customer.status).to eq("Active")
      expect(customer.name).to eq("Adam Smith")
      expect(customer["billing-system-type"]).to eq("Stripe")
    end
  end
end
