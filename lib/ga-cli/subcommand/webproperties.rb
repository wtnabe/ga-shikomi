module GACli
  module Subcommand
    class Webproperties < Base
      #
      # [{
      #   "id": "UA-xxxx-x",
      #   "internalWebPropertyId": xxxx,
      #   "permissions": []
      #   "websiteUrl": "",
      #  }]
      #
      # [return] Array
      #
      def list
        api.execute(api.analytics.management.webproperties.list, :accountId => options["account_id"])['items']
      end

      #
      # {
      #  "id": "UA-xxxx-xx",
      #  "websiteUrl": "",
      #  "permissions": []
      # }
      #
      # [return] Array
      #
      def get
        [api.execute(api.analytics.management.webproperties.get, :accountId => options['account_id'], :webPropertyId => options['property_id'])]
      end
    end
  end
end
