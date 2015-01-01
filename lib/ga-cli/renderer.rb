require 'hirb'

module GACli
  class Renderer
    #
    # [param] Array records
    # [param] Hash  oprions
    #
    def initialize(records, options)
      @records = records
      @options = options
    end
    attr_reader :records, :options

    def render_metadata
      if options[:verbose]
        puts records
      else
        picked = records.map {|e| pick_id_and_description(e)}
        opts   = {:fields => %w(id description)}

        case options[:format]
        when 'csv'
          csv(picked, opts)
        else
          table(picked, opts)
        end
      end
    end

    #
    # [param]  Hash item
    # [return] Hash
    #
    def pick_id_and_description(item)
      {
        'id'          => item['id'],
        'description' => item['attributes']['description']
      }
    end

    #
    # [param] Array result
    # [param] Hash  opts
    #
    def table(result, opts = {})
      require 'hirb'
      puts Hirb::Helpers::AutoTable.render(result, opts)
    end

    #
    # [param] Array result
    # [param] Hash  opts
    #
    def csv(result, opts = {})
      require 'csv'

      fields = opts[:fields] || result.first.keys.sort

      puts CSV.generate {|csv|
        result.each {|r|
          csv << fields.map {|f| r[f]}
        }
      }
    end
  end
end
