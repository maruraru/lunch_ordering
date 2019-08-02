require 'rails_helper'

RSpec.describe User, type: :model do

  let(:test_user) { FactoryBot.build(:user) }

  context 'is valid with valid attributes' do
    it 'is valid' do
      expect(test_user).to be_valid
    end
  end

  context 'is not valid without some attributes' do

    it 'is not valid without attributes' do
      expect(User.new).to_not be_valid
    end

    it 'is not valid without name' do
      test_user.user_name = ''
      expect(test_user).to_not be_valid
    end

    it 'is not valid without email' do
      test_user.email = ''
      expect(test_user).to_not be_valid
    end

    it 'is not valid without password' do
      test_user.password = ''
      expect(test_user).to_not be_valid
    end

    it 'is not valid without password confirmation' do
      test_user.password_confirmation = ''
      expect(test_user).to_not be_valid
    end

  end

  context 'is not valid with invalid attributes' do

    it 'is not valid with name length > 50' do
      test_user.user_name = Faker::Lorem.characters(51)
      expect(test_user).to_not be_valid
    end

    it 'is not valid with email length > 50' do
      test_user.email = Faker::Lorem.characters(51) + test_user.email
      expect(test_user).to_not be_valid
    end

    it 'is not valid with invalid email' do
      test_user.email = Faker::Lorem.characters(10)
      expect(test_user).to_not be_valid
    end

    it 'is not valid with password length > 128' do
      test_user.password = Faker::Internet.password(128, 130)
      test_user.password_confirmation = test_user.password
      expect(test_user).to_not be_valid
    end

    it 'is not valid with password length < 6' do
      test_user.password = Faker::Internet.password(1, 5)
      test_user.password_confirmation = test_user.password
      expect(test_user).to_not be_valid
    end

  end

end