module Chartmogul
  module Import
    class Customer < Base
      private

      def end_point
        "customers"
      end

      def required_keys
        [:name, :external_id, :data_source_uuid]
      end
    end
  end
end
