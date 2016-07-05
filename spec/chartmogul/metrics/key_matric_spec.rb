require "spec_helper"

describe Chartmogul::Metric do
  describe ".key_metrics" do
    it "retrieve all key matrics" do
      metric_attributes = {
        start_date: "2015-05-12",
        end_date: "2015-05-12",
        interval: "month",
        geo: "US,GB,DE",
        plans: "Bronze Plan"
      }

      stub_listing_key_metrics_api(metric_attributes)
      metrics = Chartmogul::Metric.key_metrics(metric_attributes)

      expect(metrics.entries.first.asp).not_to be_nil
      expect(metrics.entries.first.arpa).not_to be_nil
      expect(metrics.entries.first.customers).to eq(331)
      expect(metrics.entries.first["customer-churn-rate"]).not_to be_nil
    end
  end
end
