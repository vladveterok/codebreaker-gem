# frozen_string_literal: true

# top-level descriptive comment here
module Codebreaker
  # top-level descriptive comment here
  module Validation
    class GameError < StandardError; end
    class NoSavedData < GameError; end
    class UnknownDifficulty < GameError; end
    class InvalidGuess < GameError; end
    class NoHintsLeft < GameError; end
    class InvalidName < GameError; end

    def validate_user_name(name)
      raise InvalidName, 'Name should be of 3 to 20 characters' if name.length < 3 || name.length > 20
    end

    def validate_difficulty(difficulty, difficulties)
      raise UnknownDifficulty, "No such difficulty as #{difficulty}" unless difficulties.keys.any?(difficulty.to_sym)
    end

    def validate_guess(guess, length)
      raise InvalidGuess, 'Expect 4 digits' unless guess.compact.length == length
      raise InvalidGuess, 'Expect 4 digits from 1 to 6' if guess.compact.any? { |num| num < 1 || num > 6 }
    end

    def validate_hints(hints_used, hints_total)
      raise NoHintsLeft, 'No hints left, mate' if hints_used >= hints_total
    end
  end
end
