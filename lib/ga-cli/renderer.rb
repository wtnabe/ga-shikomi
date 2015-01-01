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

    def raw
      puts records
    end

    #
    # [param] Array
    # [param] Proc preprocess
    #
    def render(fields, &preprocess)
      if options[:verbose]
        puts records
      else
        result = records.map {|e| preprocess.call(e)}

        case options[:format]
        when  'csv'
          csv(result, :fields => fields)
        else
          table(result, :fields => fields)
        end
      end
    end

    def render_accounts
      render(%w(id permissions)) {|record|
        {
          'id'          => record['id'],
          'permissions' => record['permissions']['effective'].join(',')
        }
      }
    end

    def render_properties
      render(%w(id name websiteUrl permissions)) {|record|
        {
          'id'          => record['id'],
          'name'        => record['name'],
          'websiteUrl'  => record['websiteUrl'],
          'permissions' => record['permissions']['effective'].join(',')
        }
      }
    end

    def render_metadata
      render(%w(id description)) {|record| pick_id_and_description(record)}
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
