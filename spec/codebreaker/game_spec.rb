# frozen_string_literal: true

RSpec.describe Codebreaker::Game do
  subject(:game) { described_class.new(difficulty: 'easy', user_name: 'Foobar') }

  it 'has a version number' do
    expect(Codebreaker::VERSION).not_to be nil
  end

  context 'when creating a new game' do
    it 'creates a new game' do
      expect(game).to be_an_instance_of(described_class)
    end

    it 'creates a new user' do
      expect(game.user).to be_an_instance_of(Codebreaker::User)
    end
  end

  context 'when new game is created' do
    it 'is a game of particular difficulty' do
      expect(game.difficulty).to be('easy')
    end

    it 'has the right number of attempts' do
      expect(game.attempts).to be(15)
    end

    it 'has the right number of hints' do
      expect(game.number_of_hints).to be(2)
    end
  end

  context 'when starting a game' do
    before do
      game.start_new_game
    end

    it 'generates a four-number code' do
      expect(game.very_secret_code.length).to be(4)
    end

    it 'generates a code with digits from 1 to 6' do
      expect(game.very_secret_code).to all(be_between(1, 6).inclusive)
    end

    it 'generates hints equal to a very secret code' do
      expect(game.very_secret_code).to include(game.show_hint)
    end
  end

  context 'when playing the game' do
    before do
      game.start_new_game
    end

    context 'when player makes a valid guess' do
      before do
        game.guess('1234')
      end

      it 'counts attempts' do
        expect(game.attempts_used).to be(1)
      end

      it 'does not win the game' do
        expect(game.won?).to be false
      end
    end

    context 'when player makes an invalid guess' do
      it 'raises InvalidGuessError when guess < 4 digits' do
        expect { game.guess('123') }.to raise_error(described_class::InvalidGuess)
      end

      it 'raises InvalidGuessError when guess > 4 digits' do
        expect { game.guess('12345') }.to raise_error(described_class::InvalidGuess)
      end

      it 'raises InvalidGuessError when guess is not a digit of 1-6' do
        expect { game.guess('foo0') }.to raise_error(described_class::InvalidGuess)
      end
    end

    context 'when player makes a right guess' do
      before do
        game.guess(game.very_secret_code.join)
      end

      it 'shows 1,1,1,1 in clues' do
        expect(game.clues).to all(be 1)
      end

      it 'wins the game' do
        expect(game.won?).to be true
      end
    end

    context 'when attempts are left' do
      before do
        15.times { game.guess('1111') }
      end

      it 'loses the game' do
        expect(game.lost?).to be true
      end
    end
  end
end
