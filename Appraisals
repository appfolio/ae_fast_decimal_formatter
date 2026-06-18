# frozen_string_literal: true

if Gem::Requirement.new(['>= 3.3', '< 4.1']).satisfied_by?(Gem::Version.new(RUBY_VERSION))
  appraise "ruby-#{RUBY_VERSION}__actionview_72" do
    source 'https://appfolio.jfrog.io/artifactory/api/gems/appfolio-ae_fast_decimal_formatter-gem/' do
      gem 'actionview', '~> 7.2.0'
    end
  end
  appraise "ruby-#{RUBY_VERSION}__actionview_80" do
    source 'https://appfolio.jfrog.io/artifactory/api/gems/appfolio-ae_fast_decimal_formatter-gem/' do
      gem 'actionview', '~> 8.0.0'
    end
  end
  appraise "ruby-#{RUBY_VERSION}__actionview_81" do
    source 'https://appfolio.jfrog.io/artifactory/api/gems/appfolio-ae_fast_decimal_formatter-gem/' do
      gem 'actionview', '~> 8.1.0'
    end
  end
else
  raise "Unsupported Ruby version #{RUBY_VERSION}"
end
