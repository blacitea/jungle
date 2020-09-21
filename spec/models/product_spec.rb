require 'rails_helper'
require_relative '../../app/models/Product'

RSpec.describe Product, type: :model do
  describe 'Validation' do
    context 'given valid input for all fields' do
      it 'should save successfully' do
        @category = Category.create(name: 'Toys')
        #p @category
        @product = @category.products.build(name: 'Pikachu', price: 100000, quantity: 1)
        expect(@product.save).to be true
      end
    end
  end
end
