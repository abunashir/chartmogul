module Chartmogul
  module Import
    class Invoice < Base
      attr_accessor :customer_uuid

      def list(customer_uuid:, **listing_options)
        @customer_uuid = customer_uuid
        super(listing_options)
      end

      def create(customer_uuid:, invoice:)
        @customer_uuid = customer_uuid
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
