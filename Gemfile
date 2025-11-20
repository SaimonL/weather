source "https://rubygems.org"

gem "bootstrap"
gem "bootsnap", require: false
gem "bootstrap_form", "~> 5.5"
gem "haml-rails", "~> 3.0"
gem "httparty", "~> 0.23.2"
gem "importmap-rails"
gem "jquery-rails", "~> 4.6"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "rails", "~> 7.2.3"
gem "redis", ">= 4.0.1"
gem "render-text-helper"
gem "sprockets-rails"
gem "sassc-rails"
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "factory_bot_rails"
  gem "pry-rails", "~> 0.3.11"
  gem "rspec-rails", "~> 8.0"
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "web-console"
end

group :test do
  gem "database_cleaner-active_record"
  gem "database_cleaner-redis"
  gem "rails-controller-testing"
  gem "rspec-its"
  gem "rspec-stubbed_env"
  gem "simplecov", require: false
  gem "webmock"
end
