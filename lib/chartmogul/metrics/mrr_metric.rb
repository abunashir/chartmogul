module Chartmogul
  module Metric
    class MRRMetric < Base
      private

      def end_point
        "mrr"
      end
    end

    def self.mrr_metrics(start_date:, end_date:, **options)
      MRRMetric.retrieve(
        start_date: start_date, end_date: end_date, **options
      )
    end
  end
end
