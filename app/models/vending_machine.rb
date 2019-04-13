require 'tty-prompt'
require 'pry'
require_relative '../commands/calculator/service'

class VendingMachine
  attr_reader :products

  def initialize(products)
    @products = products.inject({}) do |result, product|
      result[product[:name]] ||= product
      result
    end

    @prompt = TTY::Prompt.new
  end

  def start_purchase
    selection = @prompt.select('Select product:', @products, required: true)

    puts "You have selected #{selection[:name]} which is £#{selection[:price]}"

    payment_amount = @prompt.ask('Enter payment amount:', convert: :float, required: true)

    result = Calculator::Service.call(price: selection[:price], amount: payment_amount)

    puts result.message
  end
end
