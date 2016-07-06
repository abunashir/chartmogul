module Chartmogul
  module Metric
    class LTVMetric < Base
      private

      def end_point
        "ltv"
      end
    end

    def self.ltv_metrics(start_date:, end_date:, **options)
      LTVMetric.retrieve(
        start_date: start_date, end_date: end_date, **options
      )
    end
  end
end
