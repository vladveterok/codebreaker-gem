# frozen_string_literal: true

module Codebreaker
  module Validation
    ERROR_MESSAGES = {
      invalid_name: 'Name should be of 3 to 20 characters',
      invalid_guess: 'Expect 4 digits from 1 to 6',
      no_hints_left: 'No hints left, mate',
      no_difficulty: 'No such difficulty',
      no_save_data: 'No saved data is found'
    }.freeze

    class GameError < StandardError; end
    class NoSavedData < GameError; end
    class UnknownDifficulty < GameError; end
    class InvalidGuess < GameError; end
    class NoHintsLeft < GameError; end
    class InvalidName < GameError; end

    def validate_user_name(name, length)
      raise_error(InvalidName, :invalid_name) unless length.cover?(name.length)
    end

    def validate_difficulty(difficulty, difficulties)
      raise_error(UnknownDifficulty, :no_difficulty) unless difficulties.keys.any?(difficulty.to_sym)
    end

    def validate_guess(guess, length, range)
      raise_error(InvalidGuess, :invalid_guess) unless guess.compact.length == length
      raise_error(InvalidGuess, :invalid_guess) if guess.compact.any? { |num| !range.cover? num }
    end

    def validate_hints(hints_used, hints_total)
      raise_error(NoHintsLeft, :no_hints_left) if hints_used >= hints_total
    end

    def validate_file_existens(file_path)
      raise_error(NoSavedData, :no_save_data) unless File.exist?(file_path)
    end

    def raise_error(error_class, error_message)
      raise error_class, ERROR_MESSAGES[error_message]
    end
  end
end
