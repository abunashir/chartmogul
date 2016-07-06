module Chartmogul
  module Metric
    class CustomerCount < Base
      private

      def end_point
        "customer-count"
      end
    end

    def self.cc_metrics(start_date:, end_date:, **options)
      CustomerCount.retrieve(
        start_date: start_date, end_date: end_date, **options
      )
    end
  end
end
