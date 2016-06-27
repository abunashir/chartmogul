module Chartmogul
  module Enrichment
    class Customer < Chartmogul::Base
      attr_reader :customer_id

      def find(customer_id)
        @customer_id = customer_id
        Chartmogul.get_resource(resource_end_point)
      end

      private

      def end_point
        customer_id
      end

      def resource_base
        "customers"
      end
    end
  end
end
