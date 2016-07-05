module Chartmogul
  module Metric
    class ARRMetric < Base
      private

      def end_point
        "arr"
      end
    end

    def self.arr_metrics(start_date:, end_date:, **options)
      ARRMetric.retrieve(
        start_date: start_date, end_date: end_date, **options
      )
    end
  end
end
