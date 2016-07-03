module Chartmogul
  class Base
    def self.method_missing(method_name, *arguments, &block)
      resource = new
      if resource.respond_to?(method_name, include_private: false)
        resource.send(method_name, *arguments, &block)
      end
    end

    private

    def required_keys
      []
    end

    def build_array(value)
      [value].flatten
    end

    def resource_end_point
      [resource_base, end_point].compact.join("/")
    end

    def required_keys_exist?(attributes)
      !required_keys.map { |key| attributes.include?(key) }.include?(false)
    end

    def list_resource(options = {})
      Chartmogul.get_resource(resource_end_point, options)
    end

    def create_resource(attributes)
      if required_keys_exist?(attributes)
        Chartmogul.post_resource(resource_end_point, attributes)
      else
        raise ArgumentError.new("Required keys: " + required_keys.join(", "))
      end
    end

    def update_resource(attributes)
      Chartmogul.put_resource(resource_end_point, attributes)
    end

    def delete_resource(attributes = {})
      Chartmogul.delete_resource(resource_end_point, attributes)
    end
  end
end
