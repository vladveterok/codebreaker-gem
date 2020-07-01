# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'bundler/setup'
require 'codebreaker'

# remove after every test in config -- after.each (after.all) instruction. path to remove DB_PATH
ENV['DB_FILE'] = 'results_test.yml'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
