module Chartmogul
  module Enrichment
    class Attribute < Base
      def list(customer_id:)
        set_customer_id(customer_id)
        list_resource
      end
    end
  end
end
