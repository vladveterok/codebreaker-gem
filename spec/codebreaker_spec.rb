# frozen_string_literal: true

RSpec.describe Codebreaker do
  it 'has a version number' do
    expect(Codebreaker::VERSION).not_to be nil
  end

  let(:game) { Codebreaker::Game.new(difficulty: 'easy', user_name: 'Foobar') }

  context 'when creating a new game' do
    it 'creates a new game' do
      expect(game).to be_an_instance_of(Codebreaker::Game)
    end

    it 'creates a new user' do
      expect(game.user).to be_an_instance_of(Codebreaker::User)
      expect(game.user.name).to be('Foobar')
    end
  end

  context 'when new game is created' do
    it 'is a game of particular difficulty' do
      expect(game.difficulty).to be('easy')
    end
  end
end
