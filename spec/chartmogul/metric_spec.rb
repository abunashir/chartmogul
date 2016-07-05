require "spec_helper"

describe Chartmogul::Metric do
  describe ".key_metrics" do
    it "retrieves all key matrics" do
      stub_listing_key_metrics_api(metric_attributes)
      metrics = Chartmogul::Metric.key_metrics(metric_attributes)

      expect(metrics.entries.first.asp).not_to be_nil
      expect(metrics.entries.first.arpa).not_to be_nil
      expect(metrics.entries.first["customer-churn-rate"]).not_to be_nil
    end
  end

  describe ".mrr_metrics" do
    it "retrieves the monthly recurring revenue" do
      stub_listing_mrr_metrics_api(metric_attributes)
      metrics = Chartmogul::Metric.mrr_metrics(metric_attributes)

      expect(metrics.summary.current).not_to be_nil
      expect(metrics.entries.first.mrr).not_to be_nil
      expect(metrics.entries.first["mrr-new-business"]).not_to be_nil
    end
  end

  describe ".arr_metrics" do
    it "retrieves the annualized run rate" do
      stub_listing_arr_metrics_api(metric_attributes)
      metrics = Chartmogul::Metric.arr_metrics(metric_attributes)

      expect(metrics.summary.current).not_to be_nil
      expect(metrics.entries.first.arr).not_to be_nil
      expect(metrics.entries.first.date).not_to be_nil
    end
  end

  def metric_attributes
    @metric_attributes ||= {
      start_date: "2015-05-12",
      end_date: "2015-05-12",
      interval: "month",
      geo: "US,GB,DE",
      plans: "Bronze Plan"
    }
  end
end