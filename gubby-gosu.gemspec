# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gubby/gosu/version'

Gem::Specification.new do |spec|
  spec.name          = "gubby-gosu"
  spec.version       = "0.0.1"
  spec.authors       = ["Justin Basinger"]
  spec.email         = ["justin.m.basinger@gmail.com"]
  spec.description   = "Gosu specific additions to Gubby. For games!"
  spec.summary       = "Gosu specific additions to Gubby."
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
	spec.add_development_dependency "gosu"
	spec.add_development_dependency "gubby"
	spec.add_development_dependency "ruby-prof"
	
end
