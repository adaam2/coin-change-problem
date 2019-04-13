require_relative './app/models/vending_machine'

products = {
  snickers: {
    name: 'Snickers',
    price: 10.99
  },
  mars: {
    name: 'Mars Bar',
    price: 9.99
  }
}

VendingMachine.new(products).start_purchase
