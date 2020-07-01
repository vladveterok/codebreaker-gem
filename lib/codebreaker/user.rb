# frozen_string_literal: true

# Needs a module documentation
module Codebreaker
  # User now is a data class.
  # It holds a name and validates it.
  class User
    attr_reader :name
    attr_reader :difficulty
    attr_reader :attempts
    attr_reader :attempts_used
    attr_reader :number_of_hints
    attr_reader :hints_used

    def initialize(name:)
      validate(name: name)
      @name = name
    end

    private

    def validate(arguments)
      validate_name(arguments[:name])
    end

    def validate_name(name)
      raise ArgumentError, 'Name should be of 3 to 20 characters' if name.length < 3 || name.length > 20
    end
  end
end
