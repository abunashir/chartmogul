module Chartmogul
  module Enrichment
    class Customer < Base
      def list(options = {})
        list_resource(options)
      end

      def find(customer_uuid)
        set_customer_uuid(customer_uuid)
        Chartmogul.get_resource(resource_end_point)
      end

      def search(email:)
        Chartmogul.get_resource(search_end_point, email: email)
      end

      private

      def end_point
        customer_uuid
      end

      def search_end_point
        [resource_end_point, "search"].join("/")
      end
    end
  end
end
