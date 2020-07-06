# frozen_string_literal: true

# Needs a module documentation
module Codebreaker
  # User now is a data class.
  # It holds a name.
  class User
    include Validation

    attr_reader :name

    NAME_LENGTH = [3, 20].freeze

    def initialize(name:)
      validate_user_name(name, NAME_LENGTH)
      @name = name
    end
  end
end
