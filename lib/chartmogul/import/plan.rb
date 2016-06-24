module Chartmogul
  module Import
    class Plan < Base
      private

      def end_point
        "plans"
      end

      def required_keys
        [:name, :interval_count, :interval_unit, :data_source_uuid]
      end
    end
  end
end
