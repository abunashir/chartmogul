module Chartmogul
  module Enrichment
    class Tag < Base
      def create(tag:, customer_uuid: nil, email: nil)
        create_customer_metadata(customer_uuid, email, tag)
      end

      def delete(customer_uuid:, tag:)
        delete_customer_metadata(customer_uuid, tag)
      end

      private

      def resource_key
        "tags"
      end
    end
  end
end
