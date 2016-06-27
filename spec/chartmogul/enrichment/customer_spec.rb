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

  describe ".search" do
    it "retrieves the list of customers" do
      customer_email = "adam@smith.com"

      stub_customer_search_api(email: customer_email)
      results = Chartmogul::Enrichment::Customer.search(
        email: customer_email
      )

      expect(results.page).to eq(1)
      expect(results.entries.count).to eq(1)
      expect(results.entries.first.name).to eq("Adam Smith")
      expect(results.entries.first.email).to eq(customer_email)
    end
  end
end
