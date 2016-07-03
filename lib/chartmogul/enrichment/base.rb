module Chartmogul
  module Enrichment
    class Base < Chartmogul::Base
      attr_reader :customer_id

      private

      def resource_key
      end

      def resource_base
        "customers"
      end

      def end_point
        [customer_id, "attributes", resource_key].compact.join("/")
      end

      def set_customer_id(customer_id)
        @customer_id = customer_id
      end

      def create_customer_metadata(customer_id, email, attribute)
        set_customer_id(customer_id)
        create_resource(build_attributes_hash(attribute, email))
      end

      def delete_customer_metadata(customer_id, attributes)
        set_customer_id(customer_id)
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
