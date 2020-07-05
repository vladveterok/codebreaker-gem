# frozen_string_literal: true

RSpec.describe Codebreaker::FileLoader do
  subject(:game) { Codebreaker::Game.new(difficulty: 'easy', user: user) }

  let(:user) { instance_double('User') }

  context 'when saving and loading file' do
    before do
      game.start_new_game
      game.guess(game.very_secret_code.join)
      game.save_game
    end

    it { expect(Codebreaker::Game.load).to include(game.class) }
  end
end
