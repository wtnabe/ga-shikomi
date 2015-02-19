module GACli
  module Subcommand
    class Profiles < Base
      def list
        api.execute(api.analytics.management.profiles.list, :accountId => options['account_id'], :webPropertyId => options['property_id'])['items']
      end
    end
  end
end
