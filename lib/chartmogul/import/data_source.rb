module Chartmogul
  module Import
    class DataSource
      def self.create(name:)
        Chartmogul.post_resource "import/data_sources", name: name
      end
    end
  end
end
