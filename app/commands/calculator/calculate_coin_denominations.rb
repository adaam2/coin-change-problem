require 'money'

module Calculator
  class CalculateCoinDenominations
    include Interactor

    DENOMINATIONS = [2, 1, 0.5, 0.25, 0.1, 0.05, 0.02, 0.01]

    def call
      context.fail!(message: 'No change to give') unless provide_change?

      coins = []
      remaining_amount = -context.change

      denominations.each do |coin|
        if (remaining_amount - coin) >= 0
          coin_quotient = remaining_amount / coin

          if coin_quotient != 0
            coin_quotient.to_int.times { coins << coin }
          else
            coins << coin
          end

          remaining_amount = -context.change.to_d - coins.sum
        end
      end

      coins_format = coins.map { |coin| "£#{coin}" }
      context.coins = coins

      context.message = "Paid £#{context.amount}.\nPrice was £#{context.price}.\nChange given: £#{-context.change} in denominations of #{coins_format.join(', ')}"
    end

    private

    def provide_change?
      context.change <= 0
    end

    def denominations
      context.denominations || DENOMINATIONS
    end

    def change_money
      I18n.enforce_available_locales = false

      Money.new(context.change, 'GBP')
    end
  end
end
