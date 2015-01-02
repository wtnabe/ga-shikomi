module GACli
  module Subcommand
    class Goals < Base
      def list
        api.execute(
          api.analytics.management.goals.list,
          :accountId     => options['account_id'],
          :webPropertyId => options['property_id'],
          :profileId     => options['profile_id'])['items']
      end
    end
  end
end
