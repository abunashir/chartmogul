module Chartmogul
  module Import
    class Invoice < Base
      attr_accessor :customer_uuid

      def list(uuid:, **listing_options)
        @customer_uuid = uuid
        super(listing_options)
      end

      def create(uuid:, invoice:)
        @customer_uuid = uuid
        super(invoices: build_array(invoice))
      end

      private

      def end_point
        ["customers",  customer_uuid, "invoices"].join("/")
      end

      def required_keys
        [:external_id, :date, :currency, :line_items]
      end

      def required_keys_exist?(attributes)
        invoices = attributes[:invoices]
        !invoices.map { |invoice| super(invoice) }.include?(false)
      end
    end
  end
end
