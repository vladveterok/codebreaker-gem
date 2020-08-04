# frozen_string_literal: true

module Codebreaker
  class Matchmaker
    attr_reader :clues

    CLUES = {
      exact: 1,
      non_exact: 2
    }.freeze

    def initialize(guess, secret_code)
      @secret_code = secret_code
      @guess = guess
      @clues = Array.new(4)
    end

    def match
      # collected = @secret_code.zip(@guess).delete_if { |code, guess| write_to_clues(1) if code == guess }
      collected = @secret_code.zip(@guess).delete_if { |code, guess| write_to_clues(CLUES[:exact]) if code == guess }
      @secret_code, @guess = collected.transpose

      return if @guess.nil?

      @guess.compact.each do |num|
        next unless @secret_code.any?(num)

        # write_to_clues(2)
        write_to_clues(CLUES[:non_exact])
        @secret_code[@secret_code.index(num)] = nil
      end
    end

    def write_to_clues(clue)
      @clues[@clues.find_index(nil)] = clue
    end
  end
end
