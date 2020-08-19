# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

ENV['DB_PATH'] = "#{Pathname(__FILE__).parent.dirname.realpath}/db/"
ENV['DB_FILE'] = 'results_test.yml'

require 'bundler/setup'
require 'codebreaker'

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'

  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.after do # or :each or :all, :suit
    FileUtils.rm_rf(Dir[ENV['DB_PATH']])
  end
end

RSpec::Matchers.define :be_a_directory do
  match do |dir_path|
    Dir.exist?(dir_path)
  end
end
