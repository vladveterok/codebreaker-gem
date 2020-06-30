# frozen_string_literal: true

module Codebreaker
  # Needs a class documentation
  class Game
    class InvalidGuessError < StandardError; end

    include FileLoader

    attr_reader :clues
    attr_reader :user
    attr_reader :difficulty
    attr_reader :attempts
    attr_reader :number_of_hints
    attr_reader :very_secret_code # for testing porpuse

    DIFFICULTIES = {
      easy: { attempts: 15, hints: 2 },
      medium: { attempts: 10, hints: 1 },
      hell: { attempts: 5, hints: 1 }
    }.freeze

    def initialize(difficulty:, user_name:)
      raise ArgumentError, "No such difficulty as #{difficulty}" unless DIFFICULTIES.keys.any?(difficulty.to_sym)

      @very_secret_code = []
      @hints = []
      @clues = Array.new(4)
      @attempts = DIFFICULTIES[difficulty.to_sym][:attempts]
      @number_of_hints = DIFFICULTIES[difficulty.to_sym][:hints]

      @difficulty = difficulty
      @user = User.new(name: user_name, game: self)
    end

    def start_new_game
      generate_random_code
      @hints = @very_secret_code.clone
    end

    def guess(args)
      guess = args.each_char.map(&:to_i)
      validate_guess(guess)
      clear_clues
      secret_code_clone = @very_secret_code.clone
      check_guess(guess, secret_code_clone)

      count_attempts # rename to count_attempts
    end

    def show_hint
      return "You've used all your hints, sorry, mate" if @number_of_hints.zero?

      @number_of_hints -= 1
      @hints.shuffle!.pop
    end

    def won?
      @clues.all?(0)
    end

    def lost?
      @attempts.zero?
    end

    def save_game
      @user.save_results
      save(@user)
    end

    private

    def validate_guess(guess)
      raise InvalidGuessError, 'Expect 4 digits' unless guess.compact.length == 4
      raise InvalidGuessError, 'Expect digits from 1 to 6' if guess.compact.any? { |num| num < 1 || num > 6 }
    end

    def generate_random_code
      @very_secret_code = 4.times.map { rand(1..6) }.shuffle! # [2, 2, 3, 6]
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
      @attempts -= 1
    end
  end
end
