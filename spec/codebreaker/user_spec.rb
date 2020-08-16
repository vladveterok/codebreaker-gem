# frozen_string_literal: true

RSpec.describe Codebreaker::User do
  subject(:call) { described_class.new(name: name) }

  describe '#initialize' do
    context 'when name is too short' do
      let(:name) { 'a' * (Codebreaker::User::NAME_LENGTH.min - 1) }

      it 'raises ArgumentError when less than 3 characters' do
        expect { call }.to raise_error(described_class::InvalidName)
      end
    end

    context 'when name is too long' do
      let(:name) { 'a' * (Codebreaker::User::NAME_LENGTH.max + 1) }

      it 'raises ArgumentError when more than 20 characters' do
        expect { call }.to raise_error(described_class::InvalidName)
      end
    end
  end
end
