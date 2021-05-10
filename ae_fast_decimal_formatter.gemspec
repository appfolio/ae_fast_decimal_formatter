Gem::Specification.new do |s|
  s.name        = 'ae_fast_decimal_formatter'
  s.version     = '0.1.1'
  s.summary     = 'Efficiently format decimal number'
  s.description = 'Efficiently format decimal number so that reports of millions of decimal cells are fast'
  s.authors     = ['Appfolio Inc.']
  s.email       = 'dev@appfolio.com'
  s.files       = [
    'lib/ae_fast_decimal_formatter.rb',
    'ext/ae_fast_decimal_formatter/ae_fast_decimal_formatter.c',
    'ext/ae_fast_decimal_formatter/extconf.rb'
  ]
  s.homepage    = 'https://www.github.com/appfolio/ae_fast_decimal_formatter'
  s.required_ruby_version = ['>= 2.6.3', '< 3']
  s.licenses    = ['MIT']
  s.metadata['allowed_push_host'] = 'https://rubygems.org'
  s.extensions = %w[ext/ae_fast_decimal_formatter/extconf.rb]
end
