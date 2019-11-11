# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sbrf_merchant/version'

Gem::Specification.new do |spec|
  spec.name          = 'sbrf_merchant'
  spec.version       = SbrfMerchant::VERSION
  spec.authors       = ['Eugene Kozlov']
  spec.email         = ['kozlovea8@gmail.com']

  spec.summary       = 'Sberbank Merchant'
  spec.description   = 'Sberbank Merchant API Client for Ruby'
  spec.homepage      = 'https://github.com/abstractart/sbrf_merchant'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.3.0'

  spec.files = Dir[
    'lib/**/*',
    'LICENSE.txt',
    'Rakefile',
    'README.md'
  ]

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'simplecov-console'

  spec.add_runtime_dependency 'awrence'
  spec.add_runtime_dependency 'json'
end
