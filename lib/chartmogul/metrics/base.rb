module Chartmogul
  module Metric
    class Base < Chartmogul::Base
      def retrieve(options)
        list_resource(stringify_keys(options))
      end

      private

      def resource_base
        "metrics"
      end

      def stringify_keys(options)
        Hash.new.tap do |attribute|
          options.each { |key, value| attribute[dasherize(key)] = value }
        end
      end

      def dasherize(underscored_word)
        underscored_word.to_s.tr("_", "-")
      end
    end
  end
end
