module Chartmogul
  module Metric
    class KeyMetric < Base
      def list(options)
        list_resource(stringify_keys(options))
      end

      private

      def end_point
        "all"
      end

      def stringify_keys(options)
        Hash.new.tap do |attribute|
          options.each { |key, value| attribute[dasherize(key)] = value }
        end
      end

      def dasherize(underscored_word)
        underscored_word.to_s.tr("_".freeze, "-".freeze)
      end
    end

    def self.key_metrics(start_date:, end_date:, **options)
      KeyMetric.list(
        start_date: start_date, end_date: end_date, **options
      )
    end
  end
end
