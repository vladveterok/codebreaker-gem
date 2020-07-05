# frozen_string_literal: true

# Needs a module documentation
module Codebreaker
  # User now is a data class.
  # It holds a name.
  class User
    include Validation

    attr_reader :name

    def initialize(name:)
      validate_user_name(name)
      @name = name
    end
  end
end
