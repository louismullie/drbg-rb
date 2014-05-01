$:.push File.expand_path('../lib', __FILE__)
require 'drbg-rb/version'

Gem::Specification.new do |s|
  
  s.name        = 'drbg-rb'
  s.version     = DRBG::VERSION
  s.authors     = ['Louis Mullie']
  s.email       = ['louis.mullie@gmail.com']
  
  s.homepage    = 'https://github.com/cryodex/drbg-rb'
  s.summary     = %q{ Cryptographically secure deterministic random bit generators for Ruby }
  s.description = %q{ Cryptographically secure deterministic random bit generators for Ruby }

  s.files = Dir.glob('lib/**/*.rb')
  
  s.add_development_dependency 'rspec', '~> 2.12.0'
  s.add_development_dependency 'rake'
  
end
