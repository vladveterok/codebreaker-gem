# frozen_string_literal: true

# top-level descriptive comment here
module Codebreaker
  # top-level descriptive comment here
  module Validation
    class UnknownDifficulty < StandardError; end
    class InvalidGuessError < StandardError; end

    def validate_user_name(name)
      raise ArgumentError, 'Name should be of 3 to 20 characters' if name.length < 3 || name.length > 20
    end

    def validate_difficulty(difficulty, difficulties)
      raise UnknownDifficulty, "No such difficulty as #{difficulty}" unless difficulties.keys.any?(difficulty.to_sym)
    end

    def validate_guess(guess, length)
      raise InvalidGuessError, 'Expect 4 digits' unless guess.compact.length == length
      raise InvalidGuessError, 'Expect 4 digits from 1 to 6' if guess.compact.any? { |num| num < 1 || num > 6 }
    end
  end
end
