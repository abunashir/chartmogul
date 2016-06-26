require "spec_helper"

describe Chartmogul::Import::Subscription do
  describe ".list" do
    it "lists customer subscriptions" do
      listing_options = { uuid: "customer_001", page: 1, per_page: 1 }

      stub_subscription_listing_api(listing_options)
      subscriptions = Chartmogul::Import::Subscription.list(listing_options)

      expect(subscriptions.current_page).to eq(1)
      expect(subscriptions.subscriptions.first.uuid).not_to be_nil
      expect(subscriptions.subscriptions.first.plan_uuid).not_to be_nil
      expect(subscriptions.customer_uuid).to eq(listing_options[:uuid])
    end
  end
end
