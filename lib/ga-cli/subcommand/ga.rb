module GACli
  module Subcommand
    class Ga < Base
      #
      # require
      # --profile-id
      # --begin-date
      # --end-date
      # --metrics
      def get
        opts = {
          :ids         => options['profile_id'],
          'start-date' => options['start_date'],
          'end-date'   => options['end_date'],
          :metrics     => options['metrics']
        }
        %w(dimensions
           filters
           max-results
           output
           samplingLevel
           segment
           sort
           start-index
           fields).each {|e|
          opts[e] = options[e] if options[e]
        }

        api.execute(api.analytics.data.ga.get, opts)['totalsForAllResults']
      end
    end
  end
end
