module GAShikomi
  module Subcommand
    class Base
      def initialize(api, options = {})
        @api     = api
        @options = options
      end
      attr_reader :api, :options
    end
  end
end
