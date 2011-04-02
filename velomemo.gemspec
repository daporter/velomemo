# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "velomemo/version"

Gem::Specification.new do |s|
  s.name        = "velomemo"
  s.version     = Velomemo::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["David Porter"]
  s.email       = ["david.a.porter@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Command-line ride reporting tool}
  s.description = %q{Velomemo is a command-line tool for reporting bike rides}

  s.rubyforge_project = "velomemo"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec'
end
