require 'spec_helper'

RSpec.describe Calculator::CalculateChange do
  describe '.call' do
    context 'When the change is a whole integer' do
      subject(:context) { described_class.call(price: 10, amount: 15) }

      it 'returns -£5.00 as change' do
        expect(context.change)
          .to eq -5
      end
    end

    context 'When the change is pounds and pennies' do
      subject(:context) { described_class.call(price: 10.99, amount: 15.44) }

      it 'returns a success code' do
        expect(context).to be_a_success
      end

      it 'returns -£4.45 as change' do
        expect(context.change)
          .to eq -4.45
      end
    end

    context 'When price is not provided' do
      subject(:context) { described_class.call(amount: 15.44) }

      it 'returns a failed status' do
        expect(context).to be_a_failure
      end

      it 'raises a useful error' do
        expect(context.message)
          .to eq 'Please provide a price'
      end
    end

    context 'When paid amount is not provided' do
      subject(:context) { described_class.call(price: 15.44) }

      it 'returns a failed status' do
        expect(context).to be_a_failure
      end

      it 'raises a useful error' do
        expect(context.message)
          .to eq 'Please provide an amount'
      end
    end

    context 'When the user has underpaid' do
      subject(:context) { described_class.call(price: 15, amount: 10.99) }

      it 'returns a failed status' do
        expect(context).to be_a_failure
      end

      it 'raises a useful error detailing how much more they need to pay' do
        expect(context.message)
          .to eq 'You have underpaid by £4.01'
      end
    end
  end
end
