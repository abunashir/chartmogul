module Chartmogul
  module Metric
    class Subscription < Chartmogul::Base
      attr_reader :customer_uuid

      def list(customer_uuid:, **options)
        @customer_uuid = customer_uuid
        list_resource(options)
      end

      private

      def end_point
        [customer_uuid, "subscriptions"].join("/")
      end

      def resource_base
        "customers"
      end
    end
  end
end
