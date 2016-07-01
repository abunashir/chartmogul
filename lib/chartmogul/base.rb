module Chartmogul
  class Base
    def list(options = {})
      Chartmogul.get_resource(resource_end_point, options)
    end

    def self.method_missing(method_name, *arguments, &block)
      resource = new
      if resource.respond_to?(method_name, include_private: false)
        resource.send(method_name, *arguments, &block)
      end
    end

    private

    def create_api(attributes)
      if required_keys_exist?(attributes)
        Chartmogul.post_resource(resource_end_point, attributes)
      else
        raise ArgumentError.new("Required keys: " + required_keys.join(", "))
      end
    end

    def delete_api(attributes = {})
      Chartmogul.delete_resource(resource_end_point, attributes)
    end

    def resource_end_point
      [resource_base, end_point].compact.join("/")
    end

    def required_keys_exist?(attributes)
      !required_keys.map { |key| attributes.include?(key) }.include?(false)
    end

    def required_keys
      []
    end

    def build_array(value)
      unless value.is_a?(Array)
        value = [value]
      end

      value
    end
  end
end
