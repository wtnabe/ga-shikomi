module GAShikomi
  module Subcommand
    class Segments < Base
      def list
        api.execute(api.analytics.management.segments.list)['items']
      end
    end
  end
end
