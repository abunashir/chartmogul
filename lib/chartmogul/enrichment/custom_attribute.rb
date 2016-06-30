module Chartmogul
  module Enrichment
    class CustomAttribute < Base
      attr_reader :customer_id

      def create(customer_id:, attribute:)
        @customer_id = customer_id
        create_api(custom: build_array(attribute))
      end

      private

      def end_point
        [customer_id, "attributes", "custom"].compact.join("/")
      end

      def required_keys
        [:type, :key, :value]
      end

      def required_keys_exist?(attributes)
        attributes = attributes[:custom]
        !attributes.map { |attribute| super(attribute) }.include?(false)
      end
    end
  end
end
