# frozen_string_literal: true

RSpec.describe Codebreaker::User do
  context 'when creating a new user' do
    context 'when name is invalid' do
      let(:name_too_short) { 'a' * (Codebreaker::User::NAME_LENGTH.min - 1) }
      let(:name_too_long) { 'a' * (Codebreaker::User::NAME_LENGTH.max + 1) }

      it 'raises ArgumentError when less than 3 characters' do
        expect { described_class.new(name: name_too_short) }.to raise_error(described_class::InvalidName)
      end

      it 'raises ArgumentError when more than 20 characters' do
        expect { described_class.new(name: name_too_long) }.to raise_error(described_class::InvalidName)
      end
    end
  end
end
