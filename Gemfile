# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in encoding_check.gemspec
gemspec

gem "rake", "~> 13.0"

if false    # not needed, see `gemspec` file
  gem "rchardet19", "~> 1.3"
  gem "thor", "~> 1.3"

  group :test do
    gem "rspec", "~> 3.0"
  end

  group :development, :test do
    gem "aruba", "~> 1.0"
    gem "cucumber", "~> 5.3"
    gem "rubocop", "~> 0.80"
  end
end
