require_relative './base'

module GAShikomi
  module Subcommand
    class Accounts < Base
      #
      # [{
      #    "id": "",
      #    "permission": []
      #  }]
      #
      # [return] Array
      #
      def list
        api.execute(api.analytics.management.accounts.list)['items']
      end
    end
  end
end
