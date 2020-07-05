# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

# Substitutes name for a db file 'results.yml' while testing
ENV['DB_PATH'] = "#{Pathname(__FILE__).parent.dirname.realpath}/db/"
ENV['DB_FILE'] = 'results_test.yml'

require 'bundler/setup'
require 'codebreaker'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.after(:suite) do # or :each or :all
    FileUtils.rm_rf(Dir[ENV['DB_PATH']])
  end
end
