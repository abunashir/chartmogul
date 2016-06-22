module Chartmogul
  module Import
    class DataSource
      def self.list
        Chartmogul.get_resource "import/data_sources"
      end

      def self.create(name:)
        Chartmogul.post_resource "import/data_sources", name: name
      end

      def self.delete(uuid:)
        Chartmogul.delete_resource ["import/data_sources", uuid].join("/")
      end
    end
  end
end
