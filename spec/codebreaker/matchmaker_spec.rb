# frozen_string_literal: true

RSpec.describe Codebreaker::Matchmaker do
  describe '#match' do
    test_data =
      [
        [[6, 5, 4, 3], [5, 6, 4, 3], [0, 0, 1, 1]],
        [[6, 5, 4, 3], [6, 5, 4, 4], [0, 0, 0, nil]],
        [[6, 5, 4, 3], [6, 6, 6, 6], [0, nil, nil, nil]],
        [[6, 5, 4, 3], [2, 6, 6, 6], [1, nil, nil, nil]],
        [[1, 2, 3, 4], [3, 1, 2, 4], [0, 1, 1, 1]],
        [[1, 2, 3, 4], [1, 5, 2, 4], [0, 0, 1, nil]]
      ]

    test_data.length.times do |i|
      context "when guess: #{test_data[i][0]}, code: #{test_data[i][1]}" do
        it "expects as clues: #{test_data[i][2]}" do
          matcher = described_class.new(test_data[i][0], test_data[i][1])
          matcher.match
          expect(matcher.clues).to eq(test_data[i][2])
        end
      end
    end
  end
end
