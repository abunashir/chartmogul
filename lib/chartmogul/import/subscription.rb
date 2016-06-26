module Chartmogul
  module Import
    class Subscription < Base
      attr_reader :customer_uuid

      def list(uuid:, **listing_options)
        @customer_uuid = uuid
        super(listing_options)
      end

      def cancel(uuid:, cancelled_at:)
        Chartmogul.patch_resource(
          subscription_end_point(uuid), cancelled_at: cancelled_at
        )
      end

      private

      def end_point
        ["customers", customer_uuid, "subscriptions"].join("/")
      end

      def subscription_end_point(subscription_uuid)
        ["import", "subscriptions", subscription_uuid].join("/")
      end
    end
  end
end
