module GACli; end

require_relative './version'
Dir.glob(File.dirname(__FILE__) + '/ga-cli/*.rb').each {|f| require f}
