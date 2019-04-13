require 'spec_helper'

RSpec.describe Calculator::CalculateCoinDenominations do
  describe '.call' do
    # Change is indicated by being a negative amount

    context 'When there is change to denominate into coins' do
      subject(:context) { Calculator::CalculateCoinDenominations.call(change: -11.27) }

      it 'returns success status' do
        expect(context).to be_a_success
      end

      it 'returns the largest denominations of change first' do
        expect(context.coins)
          .to eq [2, 2, 2, 2, 2, 1, 0.25, 0.02]
      end
    end

    context 'When custom denominations are provided' do
      subject(:context) { Calculator::CalculateCoinDenominations.call(change: -3.05, denominations: [2, 1, 0.02, 0.01]) }

      it 'returns the given denominations' do
        expect(context.coins)
          .to eq [2, 1, 0.02, 0.02, 0.01]
      end
    end

    context 'When the user has underpaid' do
      subject(:context) { Calculator::CalculateCoinDenominations.call(change: 5.27) }

      it 'returns no coin denominations' do
        expect(context.coins).to be_empty
      end

      it 'returns a useful message explaining the reason for failure' do
        expect(context.message).to eq 'No change to give'
      end
    end
  end
end
