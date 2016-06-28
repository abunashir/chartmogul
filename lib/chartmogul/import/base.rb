module Chartmogul
  module Import
    class Base < Chartmogul::Base
      def create(attributes)
        create_api(attributes)
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
