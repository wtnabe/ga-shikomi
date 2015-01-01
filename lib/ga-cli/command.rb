require 'thor'
Dir.glob(File.dirname(__FILE__) + '/subcommand/*.rb').each {|f| require f}

module GACli
  class Command < Thor
    class_option :begin_date
    class_option :end_date
    class_option :duration
    class_option :config_file
    class_option :credential_store
    class_option :format

    def initialize(*args)
      super

      if args.last[:current_command] != 'help'
        store = (!options.nil? && options['credential-store']) || File.join(Dir.pwd, '.ga-cli-credential')
        @api = Api.new(store)
      end
    end
    attr_reader :api

    desc 'metrices', 'display metrics'
    option :verbose, :type => :boolean
    def metrics
      Renderer.new(Subcommand::Metadata.new(api).metrics, options).render_metadata
    end

    desc 'dimensions', 'display dimensions'
    option :verbose, :type => :boolean
    def dimensions
      Renderer.new(Subcommand::Metadata.new(api).dimensions, options).render_metadata
    end
  end
end
