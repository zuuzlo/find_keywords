# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'find_keywords/version'

Gem::Specification.new do |spec|
  spec.name          = "find_keywords"
  spec.version       = FindKeywords::VERSION
  spec.authors       = ["Kirk Jarvis"]
  spec.email         = ["zuuzlo@yahoo.com"]
  spec.summary       = "Finds keywords in a sentence"
  spec.description   = "Finds keywords in a sentence.  Uses a stop word list and market word list to remove words that are not relevent."
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "pry"
end
