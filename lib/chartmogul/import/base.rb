module Chartmogul
  module Import
    class Base < Chartmogul::Base
      def list(options = {})
        list_resource(options)
      end

      def create(attributes)
        create_resource(attributes)
      end

      def delete(uuid:)
        Chartmogul.delete_resource([resource_end_point, uuid].join("/"))
      end

      private

      def resource_base
        "import"
      end
    end
  end
end
