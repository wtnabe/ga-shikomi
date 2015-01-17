module GACli
  module Subcommand
    class Ga < Base
      #
      # require
      # --profile-id
      # --begin-date
      # --end-date
      # --metrics
      def get(config)
        opts = {
          'ids'        => options['profile_id'],
          'start-date' => options['start_date'],
          'end-date'   => options['end_date'],
          'metrics'    => options['metrics']
        }
        %w(ids
           metrics
           dimensions
           filters
           max-results
           output
           samplingLevel
           segment
           sort
           start-index
           fields).each {|e|
          opts[e] = config[e] if config[e]
        } if config

        result = api.execute(api.analytics.data.ga.get, opts)

        case result['rows'].size
        when 1
          [result['totalsForAllResults']]
        else
          fields = %w(columnHeaders totalsForAllResults rows)
          fields.map {|e| {e => result[e]}}.reduce(:merge)
        end
      end
    end
  end
end
