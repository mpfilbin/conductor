# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require '../lib/conductor'

Gem::Specification.new do |spec|
  spec.name        = 'conductor'
  spec.version     = Conductor::VERSION
  spec.platform    = Gem::Platform::RUBY
  spec.authors     = ['Michael Filbin']
  spec.email       = ['mfilbin@rallydev.com']
  spec.homepage    = ''
  spec.summary     = %q{Conductor orchestrates a group of coordinating applications on your behalf}
  spec.description = %q{Conductor manages multiple concurrent applications on your behalf. This gem is helpful for developers who have to run several applications concurrently as a suite. Conductor will monitor your applications, tell you which are running, restart them if they crash, and let you kill any or all of them.}

  spec.add_development_dependency 'rspec', '~>3.2.1'
  spec.add_development_dependency 'cucumber', '~>2.0.0'
  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'reek'
  spec.add_development_dependency 'simplecov'
  
  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = %w(
                            lib/conductor
                            lib/conductor/applications
                            lib/conductor/commands
                            lib/conductor/exceptions
                            lib/conductor/kernel
                            lib/conductor/logging
                            lib/conductor/parsers
                        )
end