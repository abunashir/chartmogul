module Chartmogul
  module Metric
    class ASPMetric < Base
      private

      def end_point
        "asp"
      end
    end

    def self.asp_metrics(start_date:, end_date:, **options)
      ASPMetric.retrieve(
        start_date: start_date, end_date: end_date, **options
      )
    end
  end
end
