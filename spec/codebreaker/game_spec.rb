# frozen_string_literal: true

RSpec.describe Codebreaker::Game do
  subject(:game) { described_class.new(difficulty: difficulty.keys[0].to_s, user: user) }

  let(:user) { instance_double('User') }
  let(:difficulty) { described_class::DIFFICULTIES.slice(described_class::DIFFICULTIES.keys.sample) }
  let(:diff_values) { difficulty[difficulty.keys[0]] }

  context 'when creating a new game' do
    it { expect(game).to be_an_instance_of(described_class) }
  end

  context 'when invalide difficulty' do
    let(:klass) { described_class }

    it { expect { described_class.new(difficulty: 'invalide', user: user) }.to raise_error(klass::UnknownDifficulty) }
  end

  context 'when new game is created' do
    it { expect(game.difficulty).to eq(difficulty.keys[0].to_s) }

    it { expect(game.attempts).to be(diff_values[:attempts]) }

    it { expect(game.number_of_hints).to be(diff_values[:hints]) }
  end

  context 'when starting a game' do
    let(:min) { described_class::RANGE_GUESS_CODE.first }
    let(:max) { described_class::RANGE_GUESS_CODE.last }

    before do
      game.start_new_game
    end

    it { expect(game.very_secret_code.length).to be(described_class::CODE_LENGTH) }

    it { expect(game.very_secret_code).to all(be_between(min, max).inclusive) }

    it { expect(game.very_secret_code).to include(game.show_hint) }
  end

  context 'when playing the game' do
    before { game.start_new_game }

    context 'when player makes a valid guess' do
      before { game.guess('1234') }

      it { expect(game.attempts_used).to be(1) }

      it { expect(game.won?).to be false }
    end

    context 'when player makes an invalid guess' do
      it { expect { game.guess('123') }.to raise_error(described_class::InvalidGuess) }

      it { expect { game.guess('12345') }.to raise_error(described_class::InvalidGuess) }

      it { expect { game.guess('foo0') }.to raise_error(described_class::InvalidGuess) }
    end

    context 'when player makes a right guess' do
      before { game.guess(game.very_secret_code.join) }

      it { expect(game.clues).to all(be 1) }

      it { expect(game.won?).to be true }
    end

    context 'when attempts are left' do
      before { 15.times { game.guess('1111') } }

      it { expect(game.lost?).to be true }
    end

    context 'when hints left' do
      before do
        diff_values[:hints].times { game.show_hint }
      end

      it { expect { game.show_hint }.to raise_error(described_class::NoHintsLeft) }
    end
  end
end
