require 'hirb'
require 'pp'

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
      pp records
    end

    #
    # [param] Array
    # [param] Proc preprocess
    #
    def render(fields, &preprocess)
      if options[:format] == 'original'
        pp records
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

    def render_ga
      render(records.first.keys) {|record| record}
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

    def render_profiles
      render(%w(id name websiteUrl permissions)) {|record|
        {
          'id'          => record['id'],
          'name'        => record['name'],
          'websiteUrl'  => record['websiteUrl'],
          'permissions' => record['permissions']['effective'].join(',')
        }
      }
    end

    def render_filters
      render(%w(id name type details)) {|record|
        pick_id_name_type_and_details(record)
      }
    end

    def render_goals
      render(%w(id name type details)) {|record|
        pick_id_name_type_and_details(record)
      }
    end

    def render_metadata
      render(%w(id description)) {|record| pick_id_and_description(record)}
    end

    def render_segments
      fields = %w(id segmentId name type)

      render(fields) {|record|
        Hash[*fields.map {|f| [f, record[f]]}.flatten]
      }
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
    # [param]  Hash item
    # [return] Hash
    #
    def pick_id_name_type_and_details(item)
        {
          'id'      => item['id'],
          'name'    => item['name'],
          'type'    => item['type'],
          'details' => item["#{small_camelize(item['type'])}Details"]
        }
    end

    #
    # [param]  String str
    # [return] String str
    #
    def small_camelize(str)
      str.split('_').map {|e| e.capitalize}.tap {|a| a.first.downcase!}.join
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
        csv << fields if options[:with_csv_header]
        result.each {|r|
          csv << fields.map {|f| r[f]}
        }
      }
    end
  end
end
