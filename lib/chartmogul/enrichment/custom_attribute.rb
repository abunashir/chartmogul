module Chartmogul
  module Enrichment
    class CustomAttribute < Base
      def create(attribute:, customer_id: nil, email: nil)
        create_customer_metadata(customer_id, email, attribute)
      end

      def update(customer_id:, attribute:)
        set_customer_id(customer_id)
        update_resource(custom: attribute)
      end

      def delete(customer_id:, attribute:)
        delete_customer_metadata(customer_id, attribute)
      end

      private

      def resource_key
        "custom"
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
