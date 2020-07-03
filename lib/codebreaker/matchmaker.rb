# frozen_string_literal: true

module Codebreaker
  # Needs a class documentation
  class Matchmaker
    attr_reader :clues

    def initialize(guess, secret_code)
      @secret_code = secret_code
      @guess = guess
      @clues = Array.new(4)
    end

    def match
      collected = @secret_code.zip(@guess).delete_if { |code, guess| write_to_clues(0) if code == guess }
      @secret_code, @guess = collected.transpose

      return if @guess.nil?

      @guess.compact.each do |num|
        next unless @secret_code.any?(num)

        write_to_clues(1)
        @secret_code[@secret_code.index(num)] = nil
      end
    end

    def write_to_clues(clue)
      @clues[@clues.find_index(nil)] = clue
      # @clues << clue
    end
  end
end
