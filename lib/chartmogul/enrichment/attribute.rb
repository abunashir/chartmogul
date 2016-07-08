module Chartmogul
  module Enrichment
    class Attribute < Base
      def list(customer_uuid:)
        set_customer_uuid(customer_uuid)
        list_resource
      end
    end
  end
end
