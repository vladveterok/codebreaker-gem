# frozen_string_literal: true

RSpec.describe Codebreaker do
  subject(:game) { Codebreaker::Game.new(difficulty: 'easy', user_name: 'Foobar') }

  it 'has a version number' do
    expect(Codebreaker::VERSION).not_to be nil
  end

  context 'when creating a new game' do
    it 'creates a new game' do
      expect(game).to be_an_instance_of(Codebreaker::Game)
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

    # specify { expect(game.very_secret_code.length).to be(4) }

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
end
