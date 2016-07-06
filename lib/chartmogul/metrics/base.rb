module Chartmogul
  module Metric
    class Base < Chartmogul::Base
      attr_reader :metric_type

      def retrieve(metric_type, options)
        @metric_type = metric_type
        list_resource(stringify_keys(options))
      end

      private

      def resource_base
        "metrics"
      end

      def end_point
        custom_metric_end_point || metric_type.to_s
      end

      def custom_metric_end_point
        if separate_endpoint?
          exceptional_end_points[metric_type]
        end
      end

      def separate_endpoint?
        exceptional_end_points.keys.include?(metric_type)
      end

      def exceptional_end_points
        {
          cc: "customer-count",
          ccr: "customer-churn-rate",
          mrrcr: "mrr-churn-rate",
        }
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
