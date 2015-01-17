# -*- mode: ruby; coding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ga_cli/version'

Gem::Specification.new do |spec|
  spec.name          = "ga-cli"
  spec.version       = GACli::VERSION
  spec.authors       = ["wtnabe"]
  spec.email         = ["wtnabe@gmail.com"]
  spec.summary       = %q{Google Analytics API wrapper for CLI written in Ruby.}
  spec.description   = %q{Now, You can fetch general ga data.}
  spec.homepage      = ""
  spec.license       = "BSD"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "google-api-client"
  spec.add_runtime_dependency "thor"
  spec.add_runtime_dependency "hirb"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "> 5"
  spec.add_development_dependency "minitest-power_assert"
  spec.add_development_dependency "minitest-reporters", "> 1"
end
