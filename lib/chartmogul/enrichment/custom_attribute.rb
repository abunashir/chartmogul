module Chartmogul
  module Enrichment
    class CustomAttribute < Base
      def create(attribute:, customer_uuid: nil, email: nil)
        create_customer_metadata(customer_uuid, email, attribute)
      end

      def update(customer_uuid:, attribute:)
        set_customer_uuid(customer_uuid)
        update_resource(custom: attribute)
      end

      def delete(customer_uuid:, attribute:)
        delete_customer_metadata(customer_uuid, attribute)
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
