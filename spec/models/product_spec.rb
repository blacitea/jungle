require 'rails_helper'
require_relative '../../app/models/Product'

RSpec.describe Product, type: :model do
  describe 'Validation' do
    before do
      @category = Category.create(name: 'Toys')
    end

    context 'given valid input for all fields' do
      it 'should save successfully' do
        @product = @category.products.build(name: 'Pikachu', price: 100000, quantity: 1)
        expect(@product.save).to be true
      end
    end

    context 'given nil for 1 of the required inputs' do
      context 'given nil for name' do
        it 'should return error with name required' do
          @product = @category.products.build(name: nil, price: 100000, quantity: 1)
          expect(@product.valid?).to be false
          expect(@product.errors.any?).to be true
          expect(@product.errors[:name].any?).to be true
          expect(@product.errors.full_messages).to include('Name can\'t be blank')
        end
      end

      context 'given nil for price' do
        it 'should return error with price required' do
          @product = @category.products.build(name: 'Piko', price: nil, quantity: 1)
          expect(@product.valid?).to be false
          expect(@product.errors.any?).to be true
          expect(@product.errors[:price].any?).to be true
          expect(@product.errors.full_messages).to include('Price can\'t be blank')
        end
      end

      context 'given nil for quantity' do
        it 'should return error with quantity required' do
          @product = @category.products.build(name: 'Piko', price: 5000, quantity: nil)
          expect(@product.save).to be false
          expect(@product.errors.full_messages.size).to eq(1)
          expect(@product.errors.full_messages).to include('Quantity can\'t be blank')
        end
      end

      context 'given nil for category' do
        it 'should return error with category required' do
          @product = Product.create(name: 'Piko', price: 5000, quantity: 10)
          expect(@product.save).to be false
          expect(@product.errors.full_messages.size).to eq(1)
          expect(@product.errors.full_messages).to include('Category can\'t be blank')
        end
      end
    end
  end
end
