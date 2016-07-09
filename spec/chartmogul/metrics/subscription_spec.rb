require "spec_helper"

describe Chartmogul::Metric::Subscription do
  describe ".list" do
    it "lists the given customer's subscriptions" do
      customer_uuid = "customer_uuid_001"

      stub_customer_metric_listing_api("subscriptions", customer_uuid)
      subscriptions = Chartmogul::Metric::Subscription.list(
        customer_uuid: customer_uuid
      )

      expect(subscriptions.page).to eq(1)
      expect(subscriptions.entries.count).to eq(1)
      expect(subscriptions.entries.first.plan).not_to be_nil
    end
  end
end
