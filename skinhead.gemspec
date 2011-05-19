# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'skinhead/version'

Gem::Specification.new do |s|
  s.name        = 'skinhead'
  s.version     = Skinhead::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Priit Haamer']
  s.email       = ['priit@fraktal.ee']
  s.homepage    = ''
  s.summary     = %q{HTML5 based Template engine}
  s.description = %q{Template engine using HTML5 standard attributes to control the flow of template rendering}

  s.rubyforge_project = 'skinhead'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
  
  s.add_dependency 'nokogiri'
  
  s.add_development_dependency 'rspec', ['= 2.6.0.rc4']
end
