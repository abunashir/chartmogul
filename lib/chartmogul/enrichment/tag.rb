module Chartmogul
  module Enrichment
    class Tag < Base
      attr_reader :customer_id

      def create(tag:, customer_id: nil, email: nil)
        @customer_id = customer_id
        create_api(build_tag_attributes(tag, email))
      end

      def delete(customer_id:, tag:)
        @customer_id = customer_id

        Chartmogul.delete_resource(
          resource_end_point, tags: build_array(tag)
        )
      end

      private

      def end_point
        [customer_id, "attributes", "tags"].compact.join("/")
      end

      def build_tag_attributes(tag, email)
        Hash.new.tap do |attributes|
          attributes[:tags] = build_array(tag)

          unless email.nil?
            attributes[:email] = email
          end
        end
      end
    end
  end
end
