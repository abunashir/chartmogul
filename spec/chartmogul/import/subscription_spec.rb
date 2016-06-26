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

  describe ".cancel" do
    it "cancels the specific subscription" do
      cancellation_attributes = {
        uuid: "subscription_uuid_001",
        cancelled_at: "2016-01-15 00:00:00"
      }

      stub_subscription_cancellation_api(cancellation_attributes)
      subscription = Chartmogul::Import::Subscription.cancel(
        cancellation_attributes
      )

      expect(subscription.uuid).to eq("subscription_uuid_001")
      expect(subscription.cancellation_dates.first).to include("2016-01-15")
    end
  end
end
