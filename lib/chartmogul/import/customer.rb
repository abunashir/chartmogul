module Chartmogul
  module Import
    class Customer
      def self.create(name:, external_id:, data_source_uuid:, **args)
        required_parameters = {
          name: name,
          external_id: external_id,
          data_source_uuid: data_source_uuid
        }

        Chartmogul.post_resource(
          "import/customers", required_parameters.merge(args)
        )
      end
    end
  end
end