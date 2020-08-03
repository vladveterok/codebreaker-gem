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
      # raise InvalidName, 'Name should be of 3 to 20 characters' if name.length < length[0] || name.length > length[1]
      raise_error(InvalidName, ERROR_MESSAGES[:invalid_name]) unless length.cover? name.length
    end

    def validate_difficulty(difficulty, difficulties)
      # raise UnknownDifficulty, "No such difficulty as #{difficulty}" unless difficulties.keys.any?(difficulty.to_sym)
      raise_error(UnknownDifficulty, ERROR_MESSAGES[:no_difficulty]) unless difficulties.keys.any?(difficulty.to_sym)
    end

    def validate_guess(guess, length, range)
      # raise InvalidGuess, 'Expect 4 digits from 1 to 6' unless guess.compact.length == length
      # raise InvalidGuess, 'Expect 4 digits from 1 to 6' if guess.compact.any? { |num| num < 1 || num > 6 }
      raise_error(InvalidGuess, ERROR_MESSAGES[:invalid_guess]) unless guess.compact.length == length
      raise_error(InvalidGuess, ERROR_MESSAGES[:invalid_guess]) if guess.compact.any? { |num| !range.cover? num }
    end

    def validate_hints(hints_used, hints_total)
      # raise NoHintsLeft, 'No hints left, mate' if hints_used >= hints_total
      raise_error(NoHintsLeft, ERROR_MESSAGES[:no_hints_left]) if hints_used >= hints_total
    end

    def validate_file_existens(file_path)
      # raise Codebreaker::Validation::NoSavedData, 'No saved data is found' unless File.exist? file_path
      raise_error(NoSavedData, ERROR_MESSAGES[:no_save_data]) unless File.exist? file_path
    end

    def raise_error(error_class, error_message)
      raise error_class, error_message
    end
  end
end
