module GAShikomi; end

require_relative './ga_shikomi/version'
Dir.glob(File.dirname(__FILE__) + '/ga_shikomi/*.rb').each {|f| require f}
