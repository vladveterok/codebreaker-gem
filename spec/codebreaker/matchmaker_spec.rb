# frozen_string_literal: true

RSpec.describe Codebreaker::Matchmaker do
  describe '#match' do
    exact = :exact
    non_exact = :non_exact
    test_data =
      [
        [[6, 5, 4, 3], [5, 6, 4, 3], [exact, exact, non_exact, non_exact]],
        [[6, 5, 4, 3], [6, 5, 4, 4], [exact, exact, exact]],
        [[6, 5, 4, 3], [6, 6, 6, 6], [exact]],
        [[6, 5, 4, 3], [2, 6, 6, 6], [non_exact]],
        [[1, 2, 3, 4], [3, 1, 2, 4], [exact, non_exact, non_exact, non_exact]],
        [[1, 2, 3, 4], [1, 5, 2, 4], [exact, exact, non_exact]]
      ]

    test_data.length.times do |i|
      context "when guess: #{test_data[i][0]}, code: #{test_data[i][1]}" do
        let(:matcher) { described_class.new(test_data[i][0], test_data[i][1]) }

        before { matcher.match }

        it "expects as clues: #{test_data[i][2]}" do
          expect(matcher.clues).to eq(test_data[i][2])
        end
      end
    end
  end
end
