module Chartmogul
  module Import
    class DataSource
      def self.list
        Chartmogul.get_resource "import/data_sources"
      end

      def self.create(name:)
        Chartmogul.post_resource "import/data_sources", name: name
      end
    end
  end
end
