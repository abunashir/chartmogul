module Chartmogul
  module Enrichment
    class Base < Chartmogul::Base
      attr_reader :customer_uuid

      private

      def resource_key
      end

      def resource_base
        "customers"
      end

      def end_point
        [customer_uuid, "attributes", resource_key].compact.join("/")
      end

      def set_customer_uuid(customer_uuid)
        @customer_uuid = customer_uuid
      end

      def create_customer_metadata(customer_uuid, email, attribute)
        set_customer_uuid(customer_uuid)
        create_resource(build_attributes_hash(attribute, email))
      end

      def delete_customer_metadata(customer_uuid, attributes)
        set_customer_uuid(customer_uuid)
        delete_resource(resource_key.to_sym => build_array(attributes))
      end

      def build_attributes_hash(value, email)
        Hash.new.tap do |attributes|
          attributes[resource_key.to_sym] = build_array(value)

          unless email.nil?
            attributes[:email] = email
          end
        end
      end
    end
  end
end
