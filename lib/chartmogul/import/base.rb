module Chartmogul
  module Import
    class Base < Chartmogul::Base
      def list(options = {})
        Chartmogul.get_resource(resource_end_point, options)
      end

      def create(attributes)
        if required_keys_exist?(attributes)
          Chartmogul.post_resource(resource_end_point, attributes)
        else
          raise ArgumentError.new("Required keys: " + required_keys.join(", "))
        end
      end

      def delete(uuid:)
        Chartmogul.delete_resource([resource_end_point, uuid].join("/"))
      end

      private

      def resource_base
        "import"
      end

      def required_keys_exist?(attributes)
        !required_keys.map { |key| attributes.include?(key) }.include?(false)
      end

      def required_keys
        []
      end
    end
  end
end
