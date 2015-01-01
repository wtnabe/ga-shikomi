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
      # analytics.management.webproperties.get doesn't work !!!
      #
      # [return] Array
      #
      def get
        [list.detect {|item| item['id'] == options['property_id']}]
      end
    end
  end
end
