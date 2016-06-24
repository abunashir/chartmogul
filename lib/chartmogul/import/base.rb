module Chartmogul
  module Import
    class Base
      def create(attributes)
        if required_keys_exist?(attributes)
          Chartmogul.post_resource(["import", end_point].join("/"), attributes)
        else
          raise ArgumentError.new("Required keys: " + required_keys.join(", "))
        end
      end

      def self.method_missing(method_name, *arguments, &block)
        resource = new
        if resource.respond_to?(method_name, include_private: false)
          resource.send(method_name, *arguments, &block)
        end
      end

      private

      def required_keys
        nil
      end

      def required_keys_exist?(attributes)
        !required_keys.map { |key| attributes.include?(key) }.include?(false)
      end
    end
  end
end
