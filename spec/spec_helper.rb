require_relative "../lib/ga_shikomi"
Dir.glob(File.dirname(__FILE__) + '/support/*.rb').each {|f| require f}

require "minitest/spec"
require "minitest/autorun"
require "minitest-power_assert"
require "minitest/reporters"
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
