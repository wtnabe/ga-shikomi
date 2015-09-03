module GAShikomi
  module Subcommand
    class Ga < Base
      #
      # require
      # --profile-id
      # --begin-date
      # --end-date
      # --metrics
      def get(config)
        result = _raw_get(config)

        case result['rows'].size
        when 1
          [result['totalsForAllResults']]
        else
          fields = %w(columnHeaders totalsForAllResults rows)
          fields.map {|e| {e => result[e]}}.reduce(:merge)
        end

      end

      #
      # allow recursive call
      #
      # [param]  Hash
      # [return] Hash
      #
      def _raw_get(config)
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

        if result['nextLink']
          query = result['query']
          start = query['start-index']
          limit = query['max-results']

          rows  = result['rows']

          config['start-index'] = start + limit

          result = _raw_get(config)
          result['rows'] += rows
        end

        result
      end
    end
  end
end
