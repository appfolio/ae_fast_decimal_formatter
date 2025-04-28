# frozen_string_literal: true

case RUBY_VERSION
when '3.2.5', '3.3.6', '3.4.1'
  appraise "ruby-#{RUBY_VERSION}__actionview_70" do
    source 'https://rubygems.org' do
      gem 'actionview', '~> 7.0.0'
    end
  end
  appraise "ruby-#{RUBY_VERSION}__actionview_71" do
    source 'https://rubygems.org' do
      gem 'actionview', '~> 7.1.0'
    end
  end
  appraise "ruby-#{RUBY_VERSION}__actionview_72" do
    source 'https://rubygems.org' do
      gem 'actionview', '~> 7.2.0'
    end
  end
  appraise "ruby-#{RUBY_VERSION}__actionview_80" do
    source 'https://rubygems.org' do
      gem 'actionview', '~> 8.0.0'
    end
  end
else
  raise "Unsupported Ruby version #{RUBY_VERSION}"
end
