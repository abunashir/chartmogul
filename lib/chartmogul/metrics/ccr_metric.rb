module Chartmogul
  module Metric
    class CCRMetric < Base
      private

      def end_point
        "customer-churn-rate"
      end
    end

    def self.ccr_metrics(start_date:, end_date:, **options)
      CCRMetric.retrieve(
        start_date: start_date, end_date: end_date, **options
      )
    end
  end
end
