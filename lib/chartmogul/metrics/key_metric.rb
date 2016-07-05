module Chartmogul
  module Metric
    class KeyMetric < Base
      private

      def end_point
        "all"
      end
    end

    def self.key_metrics(start_date:, end_date:, **options)
      KeyMetric.retrieve(
        start_date: start_date, end_date: end_date, **options
      )
    end
  end
end
