require_relative('./calculate_change')
require_relative('./calculate_coin_denominations')

module Calculator
  class Service
    include Interactor::Organizer

    organize CalculateChange, CalculateCoinDenominations
  end
end
