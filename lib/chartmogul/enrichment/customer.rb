module Chartmogul
  module Enrichment
    class Customer < Base
      attr_reader :customer_id

      def find(customer_id)
        @customer_id = customer_id
        Chartmogul.get_resource(resource_end_point)
      end

      def search(email:)
        Chartmogul.get_resource(search_end_point, email: email)
      end

      private

      def end_point
        customer_id
      end

      def search_end_point
        [resource_end_point, "search"].join("/")
      end
    end
  end
end
