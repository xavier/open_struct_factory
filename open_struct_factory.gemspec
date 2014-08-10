# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'open_struct_factory/version'

Gem::Specification.new do |spec|
  spec.name          = "open_struct_factory"
  spec.version       = OpenStructFactory::VERSION
  spec.authors       = ["Xavier Defrang"]
  spec.email         = ["xavier.defrang@gmail.com"]
  spec.summary       = %q{A factory to create OpenStruct objects from nested hashes and arrays}
  spec.description   = %q{A factory to create OpenStruct objects from nested hashes and arrays}
  spec.homepage      = "http://github.com/xavier/open_struct_factory"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
