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
    end

    context 'given valid inputs' do
      it 'creates a user instance successfully' do
        @user = User.new(password: 'medley', password_confirmation: 'medley')
        p @user
        expect(@user.save).to be false
      end
    end
  end
end
