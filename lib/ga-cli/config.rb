module GACli
  class Config
    class FileNotFound < StandardError; end

    def initialize(file)
      @config = {}

      load(file)
    end
    attr_reader :config

    def load(file)
      if File.exist? file
        @config = YAML.load_file(file)
      else
        raise FileNotFound, "config_file #{file}"
      end
    end
  end
end
