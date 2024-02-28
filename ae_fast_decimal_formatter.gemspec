# frozen_string_literal: true

require_relative 'lib/ae_fast_decimal_formatter/version'

Gem::Specification.new do |spec|
  spec.name                  = 'ae_fast_decimal_formatter'
  spec.version               = AeFastDecimalFormatter::VERSION
  spec.platform              = Gem::Platform::RUBY
  spec.author                = 'AppFolio'
  spec.email                 = 'opensource@appfolio.com'
  spec.description           = 'Efficiently format decimal number.'
  spec.summary               = spec.description
  spec.homepage              = 'https://github.com/appfolio/ae_fast_decimal_formatter'
  spec.license               = 'MIT'
  spec.files                 = Dir['**/*'].select { |f| f[%r{^(lib/|ext/|LICENSE.txt|.*gemspec)}] }
  spec.require_paths         = ['lib']
  spec.extensions            = ['ext/ae_fast_decimal_formatter/extconf.rb']

  spec.required_ruby_version = Gem::Requirement.new('< 3.4')
  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
end
