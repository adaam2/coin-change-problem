require 'spec_helper'

RSpec.describe Calculator::Service do
  describe 'Composition of substituent services' do
    subject { described_class }

    it 'returns the services in the required order' do
      expect(described_class.organized.map(&:to_s))
        .to eq ['Calculator::CalculateChange', 'Calculator::CalculateCoinDenominations']
    end
  end
end
