require "spec_helper"

describe Chartmogul::Metric::Activity do
  describe ".list" do
    it "lists the given customer activities" do
      customer_uuid = "customer_uuid_001"

      stub_customer_metric_listing_api("activities", customer_uuid)
      activities = Chartmogul::Metric::Activity.list(
        customer_uuid: customer_uuid
      )

      expect(activities.page).to eq(1)
      expect(activities.entries.first.currency).to eq("USD")
      expect(activities.entries.first["activity-arr"]).to eq(240_00)
    end
  end
end
