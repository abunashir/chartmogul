module Chartmogul
  module Metric
    class Base < Chartmogul::Base
      private

      def resource_base
        "metrics"
      end
    end
  end
end
