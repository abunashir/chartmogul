module Chartmogul
  module Enrichment
    class Attribute < Base
      attr_reader :customer_id

      def list(customer_id:)
        @customer_id = customer_id
        super({})
      end

      private

      def end_point
        [customer_id, "attributes"].join("/")
      end
    end
  end
end
