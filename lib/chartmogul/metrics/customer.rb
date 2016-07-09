module Chartmogul
  module Metric
    class Customer < Chartmogul::Base
      attr_reader :customer_uuid

      def list(customer_uuid:, **listing_options)
        @customer_uuid = customer_uuid
        list_resource(listing_options)
      end

      private

      def resource_base
        ["customers", customer_uuid].join("/")
      end
    end
  end
end
