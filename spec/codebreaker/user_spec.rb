# frozen_string_literal: true

RSpec.describe Codebreaker::User do
  context 'when creating a new user' do
    context 'when name is invalid' do
      it 'raises ArgumentError when less than 3 characters' do
        expect { described_class.new(name: 'Fo') }.to raise_error(ArgumentError)
      end

      it 'raises ArgumentError when more than 20 characters' do
        expect { described_class.new(name: 'Foooooooooooooooooooo') }.to raise_error(ArgumentError)
      end
    end
  end
end
