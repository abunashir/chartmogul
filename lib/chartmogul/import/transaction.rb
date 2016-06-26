module Chartmogul
  module Import
    class Transaction < Base
      attr_reader :invoice_uuid

      def create(uuid:, **transaction_attributes)
        @invoice_uuid = uuid
        super(transaction_attributes)
      end

      private

      def end_point
        ["invoices", invoice_uuid, "transactions"].join("/")
      end

      def required_keys
        [:type, :date, :result]
      end
    end
  end
end
