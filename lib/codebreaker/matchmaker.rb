# frozen_string_literal: true

module Codebreaker
  class Matchmaker
    attr_reader :clues # , :guess

    CLUES = {
      exact: 1,
      non_exact: 2
    }.freeze

    def initialize(guess, secret_code)
      @secret_code = secret_code
      @guess = guess
      @clues = []
    end

    def match
      collected = @secret_code.zip(@guess).delete_if { |code, guess| write_to_clues(CLUES[:exact]) if code == guess }
      @secret_code, @guess = collected.transpose
      return unless @guess

      non_exact_match
    end

    def non_exact_match
      @guess.compact.each do |num|
        next unless @secret_code.any?(num)

        write_to_clues(CLUES[:non_exact])
        @secret_code[@secret_code.index(num)] = nil
      end
    end

    def write_to_clues(clue)
      @clues.push(clue)
    end
  end
end
