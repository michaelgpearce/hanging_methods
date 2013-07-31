# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require "hanging_methods/version"

Gem::Specification.new do |s|
  s.name        = "hanging_methods"
  s.version     = HangingMethods::VERSION
  s.authors     = ["Michael Pearce"]
  s.email       = ["michaelgpearce@yahoo.com"]
  s.homepage    = "http://github.com/michaelgpearce/hanging_methods"
  s.summary     = %q{Add a method that you can hang other methods}
  s.description = %q{Add a method that you can hang other methods.}
  s.license     = "MIT"

  s.rubyforge_project = "hanging_methods"

  s.files = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 2.14.0'
end
