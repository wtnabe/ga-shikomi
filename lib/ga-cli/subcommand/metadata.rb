require_relative './base'

module GACli
  module Subcommand
    class Metadata < Base
      #
      # [return] Hash
      #
      def original
        api.execute(api.analytics.metadata.columns.list, {:reportType => 'ga'})
      end

      #
      # [return] Array
      #
      def items
        original['items']
      end

      #
      # [return] Array
      #
      def metrics
        items.select {|m| m['attributes']['type'] == 'METRIC'}
      end

      #
      # [return] Array
      #
      def dimensions
        items.select {|m| m['attributes']['type'] == 'DIMENSION'}
      end
    end
  end
end
