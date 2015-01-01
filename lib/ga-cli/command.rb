require 'thor'
Dir.glob(File.dirname(__FILE__) + '/subcommand/*.rb').each {|f| require f}

module GACli
  class Command < Thor
    class_option :start_date
    class_option :end_date
    class_option :duration
    class_option :config_file
    class_option :credential_store
    class_option :format, :type => :string

    def initialize(*args)
      super

      if args.last[:current_command] != 'help'
        store = (!options.nil? && options['credential-store']) || File.join(Dir.pwd, '.ga-cli-credential')
        @api = Api.new(store)
      end
    end
    attr_reader :api

    desc 'ga', 'fetch and display ga data with profile'
    option :profile_id, :type => :string, :required => true
    option :start_date, :type => :string, :required => true
    option :end_date,   :type => :string, :required => true
    option :metrics,    :type => :string, :required => true
    def ga
      Renderer.new([Subcommand::Ga.new(api, options).get], options).render_ga
    end

    desc 'accounts', 'display accounts'
    def accounts
      Renderer.new(Subcommand::Accounts.new(api).list, options).render_accounts
    end

    desc 'properties', 'display properties'
    option :account_id, :type => :string, :required => true
    def properties
      Renderer.new(Subcommand::Webproperties.new(api, options).list, options).render_properties
    end

    desc 'property', 'display property'
    option :account_id,  :type => :string, :required => true
    option :property_id, :type => :string, :required => true
    def property
      Renderer.new(Subcommand::Webproperties.new(api, options).get, options).render_properties
    end

    desc 'metrices', 'display metrics'
    def metrics
      Renderer.new(Subcommand::Metadata.new(api).metrics, options).render_metadata
    end

    desc 'dimensions', 'display dimensions'
    def dimensions
      Renderer.new(Subcommand::Metadata.new(api).dimensions, options).render_metadata
    end
  end
end
