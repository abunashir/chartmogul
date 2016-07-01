module Chartmogul
  module Enrichment
    class CustomAttribute < Base
      attr_reader :customer_id

      def create(attribute:, customer_id: nil, email: nil)
        @customer_id = customer_id
        create_api(build_custom_attributes(attribute, email))
      end

      def update(customer_id:, attribute:)
        @customer_id = customer_id
        Chartmogul.put_resource(resource_end_point, custom: attribute)
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

      def build_custom_attributes(attribute, email)
        Hash.new.tap do |attributes|
          attributes[:custom] = build_array(attribute)

          unless email.nil?
            attributes[:email] = email
          end
        end
      end
    end
  end
end
