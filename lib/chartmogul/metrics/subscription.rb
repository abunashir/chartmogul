module Chartmogul
  module Metric
    class Subscription < Customer
      private

      def end_point
        "subscriptions"
      end
    end
  end
end
