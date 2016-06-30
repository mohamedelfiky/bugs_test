source 'https://rubygems.org'

gem 'rails', '4.2.5'
gem 'rails-api'
gem 'mysql2'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Fake data generator for tests and seeds
gem 'faker'

group :development do
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'guard-rubocop'

  # Static code analyzer
  gem 'rubocop', require: false

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background.
  gem 'spring'
end

group :development, :test do
  gem 'byebug'

  # Cleane database in tests
  gem 'database_cleaner'
  # Replacement for fixtures
  gem 'factory_girl_rails'
  # Testing framework
  gem 'rspec-rails', '~> 3.0'
  # Rspec one-liners
  gem 'shoulda-matchers', '~> 3.1'
  # Coverage reports generator
  gem 'simplecov', require: false
end

group :test do
  # Use sqlite3 as the database for test env
  gem 'sqlite3'
  # Reporting test coverage to Code Climate
  gem 'codeclimate-test-reporter', require: nil
end
