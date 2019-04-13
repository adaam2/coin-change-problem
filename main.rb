require 'faker'

require_relative './app/models/vending_machine'
require_relative './app/models/product'

products = (1...10).map do |i|
  Product.new(Faker::Commerce.product_name, Faker::Commerce.price(1..10))
end

VendingMachine.new(products.map(&:to_h)).start_purchase
