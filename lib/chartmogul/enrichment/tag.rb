module Chartmogul
  module Enrichment
    class Tag < Base
      def create(tag:, customer_id: nil, email: nil)
        create_customer_metadata(customer_id, email, tag)
      end

      def delete(customer_id:, tag:)
        delete_customer_metadata(customer_id, tag)
      end

      private

      def resource_key
        "tags"
      end
    end
  end
end
