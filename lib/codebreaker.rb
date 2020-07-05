# frozen_string_literal: true

require_relative 'codebreaker/version'
require 'yaml/store'
require 'pathname'

require_relative 'codebreaker/modules/validation'
require_relative 'codebreaker/modules/file_loader'
require_relative 'codebreaker/game'
require_relative 'codebreaker/matchmaker'
require_relative 'codebreaker/user'

module Codebreaker
  class Error < StandardError; end
  # Your code goes here...
end
