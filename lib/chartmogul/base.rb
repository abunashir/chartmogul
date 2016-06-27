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

    def resource_end_point
      [resource_base, end_point].compact.join("/")
    end
  end
end
