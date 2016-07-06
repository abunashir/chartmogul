require "spec_helper"

describe Chartmogul::Metric do
  describe ".key_metrics" do
    it "retrieves all key matrics" do
      stub_retrieving_metrics_api("all", metric_attributes)
      metrics = Chartmogul::Metric.key_metrics(metric_attributes)

      expect(metrics.entries.first.asp).not_to be_nil
      expect(metrics.entries.first.arpa).not_to be_nil
      expect(metrics.entries.first["customer-churn-rate"]).not_to be_nil
    end
  end

  describe ".mrr_metrics" do
    it "retrieves the monthly recurring revenue metrics" do
      stub_retrieving_metrics_api("mrr", metric_attributes)
      metrics = Chartmogul::Metric.mrr_metrics(metric_attributes)

      expect(metrics.summary.current).not_to be_nil
      expect(metrics.entries.first.mrr).not_to be_nil
      expect(metrics.entries.first["mrr-new-business"]).not_to be_nil
    end
  end

  describe ".arr_metrics" do
    it "retrieves the annualized run rate metrics" do
      stub_retrieving_metrics_api("arr", metric_attributes)
      metrics = Chartmogul::Metric.arr_metrics(metric_attributes)

      expect(metrics.summary.current).not_to be_nil
      expect(metrics.entries.first.arr).not_to be_nil
      expect(metrics.entries.first.date).not_to be_nil
    end
  end

  describe ".arpa_metrics" do
    it "retrieves the average revenue per account metrics" do
      stub_retrieving_metrics_api("arpa", metric_attributes)
      metrics = Chartmogul::Metric.arpa_metrics(metric_attributes)

      expect(metrics.summary.current).not_to be_nil
      expect(metrics.entries.first.arpa).not_to be_nil
      expect(metrics.entries.first.date).not_to be_nil
    end
  end

  describe ".asp_metrics" do
    it "retrieves the average sale price metrics" do
      stub_retrieving_metrics_api("asp", metric_attributes)
      metrics = Chartmogul::Metric.asp_metrics(metric_attributes)

      expect(metrics.summary.current).not_to be_nil
      expect(metrics.entries.first.asp).not_to be_nil
      expect(metrics.entries.first.date).not_to be_nil
    end
  end

  describe ".cc_metrics" do
    it "retrieves the number of active customers metrics" do
      stub_retrieving_metrics_api("customer-count", metric_attributes)
      metrics = Chartmogul::Metric.cc_metrics(metric_attributes)

      expect(metrics.summary.current).not_to be_nil
      expect(metrics.entries.first.customers).not_to be_nil
    end
  end

  describe ".ccr_metrics" do
    it "retrieves the customer churn rate metrics" do
      stub_retrieving_metrics_api("customer-churn-rate", metric_attributes)
      metrics = Chartmogul::Metric.ccr_metrics(metric_attributes)

      expect(metrics.summary.current).not_to be_nil
      expect(metrics.entries.first["customer-churn-rate"]).not_to be_nil
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
