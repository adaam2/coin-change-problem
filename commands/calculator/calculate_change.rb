require 'interactor'

module Calculator
  class CalculateChange
    include Interactor

    def call
      context.fail!(message: 'Please provide a price') unless has_price?
      context.fail!(message: 'Please provide an amount') unless has_amount?
      context.fail!(message: "You have underpaid by £#{underpayment_amount}") if has_underpaid?

      price, amount = price_and_amount

      change = price - amount
      context.change = change.round(2)
    end

    private

    def has_price?
      context_hash.key? :price
    end

    def has_amount?
      context_hash.key? :amount
    end

    def has_underpaid?
      price, amount = price_and_amount

      price > amount
    end

    def underpayment_amount
      price, amount = price_and_amount

      price - amount
    end

    def price_and_amount
      context
        .to_h
        .values_at(:price, :amount)
    end

    def context_hash
      context.to_h
    end
  end
end
