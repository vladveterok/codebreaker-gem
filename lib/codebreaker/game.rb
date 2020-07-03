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
      @clues = []
      # CRAFTING MATCHER! @clues = Array.new(4)
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
      # CRAFTING MATCHER! clear_clues
      # CRAFTING MATCHER! secret_code_clone = @very_secret_code.clone
      check_guess(guess, very_secret_code)

      count_attempts
    end

    def show_hint
      validate_hints(hints_used, number_of_hints)

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

    def check_guess(guess, secret_code)
      matchmaker = Codebreaker::Matchmaker.new(guess, secret_code)
      matchmaker.match
      @clues = matchmaker.clues
    end

    # def add_to_clues!(clue)
    #  @clues[@clues.find_index(nil)] = clue
    #  @clues << clue
    # end

    # CRAFTING MATCHER!
    # def clear_clues
    #  @clues = [nil, nil, nil, nil]
    # end

    def count_attempts
      @attempts_used += 1
    end
  end
end
