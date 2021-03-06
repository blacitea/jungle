require 'rails_helper'
require_relative '../../app/models/User'

RSpec.describe User, type: :model do
  describe 'Validation' do
    context 'missing 1 required field' do
      it 'cannot create when missing first name' do
        @user = User.create(first_name:nil)
        expect(@user.errors.any?).to be true
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'cannot create when missing last name' do
        @user = User.create(first_name: 'Mike', last_name:nil)
        expect(@user.errors.any?).to be true
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'cannot create when missing email' do
        @user = User.create(first_name: 'Mike', last_name: 'Medley', email: nil)
        expect(@user.errors.any?).to be true
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'cannot create when missing password' do
        @user = User.create(first_name: 'Mike', last_name: 'Medley', email: 'mike@ymail.com', password: nil)
        expect(@user.errors.any?).to be true
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'cannot create when missing password confirmation' do
        @user = User.create(first_name: 'Mike', last_name: 'Medley', email: 'mike@ymail.com', password: 'jungle')
        expect(@user.errors.any?).to be true
        expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
      end

    end

    context 'email uniqueness ' do
      before do
        @user1 = User.create(first_name: 'Alice', last_name: 'Mi', password: 'jungle', password_confirmation: 'jungle', email: 'mi@ymail.com')
      end
      it 'not create a user if email already registered' do
        @user2 = User.create(first_name: 'Bob', last_name: 'Mi', password: 'store', password_confirmation: 'store', email: 'mi@ymail.com')
        expect(@user2.errors.size).to eq(1)
        expect(@user2.errors.full_messages).to include('Email has already been taken')
      end
      it 'not create a user if email already registered - case check' do
        @user2 = User.create(first_name: 'Bob', last_name: 'Mi', password: 'store', password_confirmation: 'store', email: 'mi@YMAIL.com')
        expect(@user2.errors.size).to eq(1)
        expect(@user2.errors.full_messages).to include('Email has already been taken')
      end
    end

    context 'password confirmation' do
      it 'cannot create if password confirmation not match' do
        @user = User.create(first_name: 'Alice', last_name: 'Mi', password: 'jungle', password_confirmation: 'book', email: 'mi@ymail.com')
        expect(@user.errors.size).to eq(1)
        expect(@user.errors.full_messages[0]).to match("Password confirmation doesn't match Password")
      end
    end

    context 'password minimum length' do
      it 'cannot create if given password less than 5 character' do
        @user = User.create(first_name: 'Alice', last_name: 'Mi', password: 'room', password_confirmation: 'room', email: 'mi@ymail.com')
        expect(@user.errors.full_messages).to include('Password minimum 5 characters required.')
      end
    end

    context 'happy case' do
      it 'creates a user instance successfully given all valid inputs' do
        @user = User.create(first_name: 'Alice', last_name: 'Mi', password: 'jungle', password_confirmation: 'jungle', email: 'mi@ymail.com')
        expect(@user.errors.any?).to be false
        expect(@user.save).to be true
      end
    end
  end



  describe '.authenticate_with_credentials' do
    before do
      @user = User.create(first_name: 'Alice', last_name: 'Mi', password: 'jungle', password_confirmation: 'jungle', email: 'mi@ymail.com')
    end

    context 'given user email and password' do
      it 'returns user instance if authenticated' do
        @user = User.authenticate_with_credentials('mi@ymail.com', 'jungle')
        expect(@user.first_name).to match('Alice')
        expect(@user.last_name).to match('Mi')
      end

      it 'no user instance returned if authentication failed' do
        @user = User.authenticate_with_credentials('mi@ymail.com', 'book')
        expect(@user).to be false
      end
    end
  end

  describe 'edge case' do

    before do
      @user1 = User.create(first_name: 'Alice', last_name: 'Mi', password: 'jungle', password_confirmation: 'jungle', email: 'mi@ymail.com')
    end

    context 'extra space before/after email should still validate' do
      it 'returns a user instance with space before' do
        @user = User.authenticate_with_credentials('  mi@ymail.com', 'jungle')
        expect(@user.first_name).to match('Alice')
        expect(@user.last_name).to match('Mi')
      end

      it 'returns a user instance with space after' do
        @user = User.authenticate_with_credentials('mi@ymail.com   ', 'jungle')
        expect(@user.first_name).to match('Alice')
        expect(@user.last_name).to match('Mi')
      end
    end

    context 'still validate with wrong case for email' do
      it 'returns user instance given with uppercase email' do
        @user = User.authenticate_with_credentials('MI@YMAIL.COM', 'jungle')
        expect(@user.first_name).to match('Alice')
        expect(@user.last_name).to match('Mi')
      end

      it 'returns user instance given with lower email' do
        @user2 = User.create(first_name: 'Bob', last_name: 'Mi', password: 'jungle', password_confirmation: 'jungle', email: 'BOB@YMAIL.COM')
        @user = User.authenticate_with_credentials('BoB@ymail.com', 'jungle')
        expect(@user.first_name).to match('Bob')
        expect(@user.last_name).to match('Mi')
      end

    end
  end

end
