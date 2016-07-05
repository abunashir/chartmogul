module Chartmogul
  module Metric
    class ARPAMetric < Base
      private

      def end_point
        "arpa"
      end
    end

    def self.arpa_metrics(start_date:, end_date:, **options)
      ARPAMetric.retrieve(
        start_date: start_date, end_date: end_date, **options
      )
    end
  end
end
