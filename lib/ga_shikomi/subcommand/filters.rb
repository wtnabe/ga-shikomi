module GAShikomi
  module Subcommand
    class Filters < Base
      def list
        api.execute(api.analytics.management.filters.list, :accountId => options['account_id'])['items']
      end
    end
  end
end
