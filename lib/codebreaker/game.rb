# frozen_string_literal: true

module Codebreaker
  # Public interfaces for this lovely game are described in README.md ^^
  class Game
    include Validation
    include FileLoader

    attr_reader :clues, :user, :difficulty, :attempts, :number_of_hints, :attempts_used, :hints_used, :very_secret_code

    DIFFICULTIES = {
      easy: { attempts: 15, hints: 2 },
      medium: { attempts: 10, hints: 1 },
      hell: { attempts: 5, hints: 1 }
    }.freeze
    CODE_LENGTH = 4
    DIGIT_MAX = 6

    def initialize(difficulty:, user:)
      validate_difficulty(difficulty, DIFFICULTIES)

      @user = user
      @difficulty = difficulty
      @attempts = DIFFICULTIES[difficulty.to_sym][:attempts]
      @number_of_hints = DIFFICULTIES[difficulty.to_sym][:hints]

      @very_secret_code = []
      @hints = []
      @attempts_used = 0
      @hints_used = 0
    end

    def start_new_game
      @very_secret_code = generate_random_code
      @hints = @very_secret_code.clone
      @attempts_used = 0
      @hints_used = 0
      @clues = Array.new(4)
    end

    def guess(args)
      guess = args.each_char.map(&:to_i)
      validate_guess(guess, CODE_LENGTH)
      check_guess(guess, very_secret_code)

      count_attempts
    end

    def show_hint
      validate_hints(hints_used, number_of_hints)

      @hints_used += 1
      @hints.shuffle!.pop
    end

    def won?
      @clues.all?(1)
    end

    def lost?
      @attempts_used >= @attempts
    end

    def save_game
      save(self)
    end

    private

    def generate_random_code
      CODE_LENGTH.times.map { rand(1..DIGIT_MAX) }.shuffle!
    end

    def check_guess(guess, secret_code)
      matchmaker = Codebreaker::Matchmaker.new(guess, secret_code)
      matchmaker.match
      @clues = matchmaker.clues
    end

    def count_attempts
      @attempts_used += 1
    end
  end
end
