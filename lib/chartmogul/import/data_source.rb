module Chartmogul
  module Import
    class DataSource < Base
      private

      def end_point
        "data_sources"
      end

      def required_keys
        [:name]
      end
    end
  end
end
