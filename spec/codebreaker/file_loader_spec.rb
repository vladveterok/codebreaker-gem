# frozen_string_literal: true

RSpec.describe Codebreaker::FileLoader do
  let(:game) { Codebreaker::Game.new(difficulty: 'easy', user: user) }
  let(:user) { instance_double('User') }

  context 'when saving and loading file' do
    before { game.save_game }

    it { expect(Codebreaker::Game.load).to include(game.class) }
  end

  context 'when no saved data' do
    it { expect { Codebreaker::Game.load }.to raise_error(Codebreaker::Validation::NoSavedData) }
  end

  context 'when saving file' do
    before do
      game.save_game
    end

    it { expect(ENV['DB_PATH']).to be_a_directory }
  end
end
