module Chartmogul
  module Import
    class Subscription < Base
      attr_reader :customer_uuid

      def list(uuid:, **listing_options)
        @customer_uuid = uuid
        super(listing_options)
      end

      private

      def end_point
        ["customers", customer_uuid, "subscriptions"].join("/")
      end
    end
  end
end
