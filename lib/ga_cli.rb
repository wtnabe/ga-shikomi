module GACli; end

require_relative './ga_cli/version'
Dir.glob(File.dirname(__FILE__) + '/ga_cli/*.rb').each {|f| require f}
