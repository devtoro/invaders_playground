# frozen_string_literal: true

Gem::Specification.new do |s|
  s.required_ruby_version = '3.0.0'
  s.name        = 'space_radar'
  s.version     = '0.0.1'
  s.summary     = 'A simple cli to find ascii space invaders.'
  s.description = 'A simple cli to find ascii space invaders.'
  s.authors     = ['Manolis Tsilikidis']
  s.email       = 'manolistsilikidis@gmail.com'
  s.files       = Dir['lib/**/*.rb'] + Dir['spec/**/*.rb']
  s.homepage    = 'https://github.com/devtoro'
  s.license     = 'MIT'
  s.add_development_dependency 'byebug', ['11.1.13']
end
