# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'orm_adapter_aws/version'

Gem::Specification.new do |gem|
  gem.name          = "orm_adapter_aws"
  gem.version       = OrmAdapterAws::VERSION
  gem.authors       = ["Jeremy Green"]
  gem.email         = ["jeremy@octolabs.com"]
  gem.description   = %q{A SimpleDB adapter for the orm_adapter gem.}
  gem.summary       = %q{A SimpleDB adapter for the orm_adapter gem.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "aws-sdk", "~> 1.8.0"
  gem.add_dependency "orm_adapter", "~> 0.4.0"
  gem.add_development_dependency "rspec", ">= 2.0.0"

end
