require 'spec_helper'

RSpec.describe Product do
  subject {
    described_class.new('Banana', 10.99)
  }

  describe '.to_h' do
    it 'returns the expected format' do
      expect(subject.to_h).to eq({
        name: 'Banana',
        price: 10.99
      })
    end
  end
end
