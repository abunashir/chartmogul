module Chartmogul
  module Metric
    class MRRCRMetric < Base
      private

      def end_point
        "mrr-churn-rate"
      end
    end

    def self.mrrcr_metrics(start_date:, end_date:, **options)
      MRRCRMetric.retrieve(
        start_date: start_date, end_date: end_date, **options
      )
    end
  end
end
