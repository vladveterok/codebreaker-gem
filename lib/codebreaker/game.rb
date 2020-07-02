# frozen_string_literal: true

module Codebreaker
  # Needs a class documentation
  class Game
    # class InvalidGuessError < StandardError; end

    include Validation
    include FileLoader

    attr_reader :clues
    attr_reader :user
    attr_reader :difficulty
    attr_reader :attempts
    attr_reader :number_of_hints
    attr_reader :attempts_used
    attr_reader :hints_used
    attr_reader :very_secret_code # for testing porpuse

    DIFFICULTIES = {
      easy: { attempts: 15, hints: 2 },
      medium: { attempts: 10, hints: 1 },
      hell: { attempts: 5, hints: 1 }
    }.freeze
    CODE_LENGTH = 4

    def initialize(difficulty:, user_name:)
      validate_difficulty(difficulty, DIFFICULTIES)

      @user = User.new(name: user_name)
      @difficulty = difficulty
      @attempts = DIFFICULTIES[difficulty.to_sym][:attempts]
      @number_of_hints = DIFFICULTIES[difficulty.to_sym][:hints]

      @very_secret_code = []
      @hints = []
      @clues = Array.new(4)
      @attempts_used = 0
      @hints_used = 0
    end

    def start_new_game
      generate_random_code
      @hints = @very_secret_code.clone
    end

    def guess(args)
      guess = args.each_char.map(&:to_i)
      validate_guess(guess, CODE_LENGTH)
      clear_clues
      secret_code_clone = @very_secret_code.clone
      check_guess(guess, secret_code_clone)

      count_attempts
    end

    def show_hint
      return if @hints_used >= number_of_hints

      @hints_used += 1
      @hints.shuffle!.pop
    end

    def won?
      @clues.all?(0)
    end

    def lost?
      @attempts_used >= attempts
    end

    def save_game
      save(self)
    end

    private

    def generate_random_code
      @very_secret_code = CODE_LENGTH.times.map { rand(1..6) }.shuffle! # [2, 2, 3, 6]
    end

    def check_guess(guess, secret_code_clone)
      guess.length.times do |i|
        next unless secret_code_clone[i] == guess[i]

        add_to_clues!(0)
        secret_code_clone[i] = guess[i] = nil
      end

      guess.compact.each do |num|
        next unless secret_code_clone.any?(num)

        add_to_clues!(1)
        secret_code_clone[secret_code_clone.index(num)] = nil
      end
    end

    def add_to_clues!(clue)
      @clues[@clues.find_index(nil)] = clue
      # @clues << clue
    end

    def clear_clues
      @clues = [nil, nil, nil, nil]
    end

    def count_attempts
      @attempts_used += 1
    end

    # def validate_difficulty(difficulty)
    #  raise ArgumentError, "No such difficulty as #{difficulty}" unless DIFFICULTIES.keys.any?(difficulty.to_sym)
    # end

    # def validate_guess(guess)
    #  raise InvalidGuessError, 'Expect 4 digits' unless guess.compact.length == 4
    #  raise InvalidGuessError, 'Expect 4 digits from 1 to 6' if guess.compact.any? { |num| num < 1 || num > 6 }
    # end
  end
end
