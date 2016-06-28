module Chartmogul
  module Enrichment
    class Tag < Base
      attr_reader :customer_id

      def create(customer_id:, tag:)
        @customer_id = customer_id
        create_api(tags: build_array(tag))
      end

      private

      def end_point
        [customer_id, "attributes", "tags"]
      end
    end
  end
end
