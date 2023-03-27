# frozen_string_literal: true

case RUBY_VERSION
when '2.7.7'
  appraise "ruby-#{RUBY_VERSION}_actionview60" do
    source 'https://rubygems.org' do
      gem 'actionview', '~> 6.0.0'
    end
  end

  appraise "ruby-#{RUBY_VERSION}_actionview61" do
    source 'https://rubygems.org' do
      gem 'actionview', '~> 6.1.0'
    end
  end

  appraise "ruby-#{RUBY_VERSION}_actionview70" do
    source 'https://rubygems.org' do
      gem 'actionview', '~> 7.0.0'
    end
  end
when '3.1.3', '3.2.1'
  appraise "ruby-#{RUBY_VERSION}_actionview61" do
    source 'https://rubygems.org' do
      gem 'actionview', '~> 6.1.0'
    end
  end

  appraise "ruby-#{RUBY_VERSION}_actionview70" do
    source 'https://rubygems.org' do
      gem 'actionview', '~> 7.0.0'
    end
  end
else
  raise "Unsupported Ruby version #{RUBY_VERSION}"
end
