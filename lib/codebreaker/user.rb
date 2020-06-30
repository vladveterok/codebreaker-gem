# frozen_string_literal: true

# Needs a module documentation
module Codebreaker
  # Needs a class documentation
  class User
    attr_reader :name
    attr_reader :difficulty
    attr_reader :attempts
    attr_reader :attempts_used
    attr_reader :number_of_hints
    attr_reader :hints_used

    def initialize(name:, game:)
      validate(name: name, game: game) # add all attributes
      @name = name
      @game = game

      @difficulty = @game.difficulty
      @attempts = @game.attempts
      @number_of_hints = @game.number_of_hints

      @attempts_used = 0
      @hints_used = 0
    end

    def save_results
      @attempts_used = @attempts - @game.attempts
      @hints_used = @number_of_hints - @game.number_of_hints
      # save results from game to here
    end

    private

    def validate(arguments)
      validate_name(arguments[:name])
    end

    def validate_name(name)
      raise ArgumentError, 'Name should be of 3 to 20 characters' if name.length < 3 || name.length > 20
    end

    def to_s
      "name: #{@name} " \
      "difficulty: #{@difficulty} " \
      "attempts total #{@attempts} " \
      "attempts used: #{@attempts_used} " \
      "hints total: #{@number_of_hints} " \
      "hints used: #{@hints_used}"
    end
  end
end
