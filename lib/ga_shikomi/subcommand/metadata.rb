require_relative './base'

module GAShikomi
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
        items.select {|m| m['attributes']['type'] == 'METRIC' && visible?(m)}
      end

      #
      # [return] Array
      #
      def dimensions
        items.select {|m| m['attributes']['type'] == 'DIMENSION' && visible?(m)}
      end

      #
      # [param]  Hash item
      # [return] Boolean
      #
      def visible?(item)
        if options[:include_deprecated]
          true
        else
          item['attributes']['status'] == 'PUBLIC'
        end
      end
    end
  end
end
