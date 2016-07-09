require "chartmogul/metrics/base"
require "chartmogul/metrics/subscription"

module Chartmogul
  module Metric
    def self.metric_types
      [:all, :mrr, :arr, :arpa, :asp, :cc, :ccr, :mrrcr, :ltv]
    end

    def self.define_metric_singleton_method(method_prefix)
      method_name = [method_prefix, "metrics"].join("_")
      define_singleton_method(method_name) do |start_date:, end_date:, **attrs|
        Metric::Base.retrieve(
          method_prefix, start_date: start_date, end_date: end_date, **attrs
        )
      end
    end

    metric_types.each do |metric_type|
      define_metric_singleton_method(metric_type)
    end
  end
end
