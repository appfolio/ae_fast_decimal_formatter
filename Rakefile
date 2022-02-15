# frozen_string_literal: true

require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  warn e.message
  warn 'Run `bundle install` to install missing gems'
  exit e.status_code
end

require 'rspec/core/rake_task'
require 'rake/extensiontask'

Rake::ExtensionTask.new(:ae_fast_decimal_formatter) do |ext|
  ext.lib_dir = 'lib/ae_fast_decimal_formatter'
end

RSpec::Core::RakeTask.new(:test)

task default: :test
