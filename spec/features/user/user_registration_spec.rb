require 'rails_helper'

RSpec.describe 'UserRegistrations', type: :feature do
  let(:user1) { FactoryBot.build(:user) }

  context 'when all fields are correct' do
    it 'signs up' do
      visit '/users/sign_up'
      within('#new_user') do
        fill_in 'user_email', with: user1.email
        fill_in 'user_user_name', with: user1.user_name
        fill_in 'user_password', with: user1.password
        fill_in 'user_password_confirmation', with: user1.password_confirmation
      end
      click_button 'Sign up'
      expect(page).to have_text 'signed up successfully'
    end
  end

  context 'when some fields are invalid' do
    it 'fails if email is not unique' do
      user1.save
      visit '/users/sign_up'
      within('#new_user') do
        fill_in 'user_email', with: user1.email
        fill_in 'user_user_name', with: user1.user_name
        fill_in 'user_password', with: user1.password
        fill_in 'user_password_confirmation', with: user1.password_confirmation
      end
      click_button 'Sign up'
      expect(page).to have_text 'Email has already been taken'
    end

    it 'fails if email is empty' do
      visit '/users/sign_up'
      within('#new_user') do
        fill_in 'user_email', with: ''
        fill_in 'user_user_name', with: user1.user_name
        fill_in 'user_password', with: user1.password
        fill_in 'user_password_confirmation', with: user1.password_confirmation
      end
      click_button 'Sign up'
      expect(page).to have_text "can't be blank"
    end

    it 'fails if password is empty' do
      visit '/users/sign_up'
      within('#new_user') do
        fill_in 'user_email', with: user1.email
        fill_in 'user_user_name', with: user1.user_name
        fill_in 'user_password', with: ''
        fill_in 'user_password_confirmation', with: user1.password_confirmation
      end
      click_button 'Sign up'
      expect(page).to have_text "can't be blank"
    end

    it 'fails if password confirmation is incorrect' do
      visit '/users/sign_up'
      within('#new_user') do
        fill_in 'user_email', with: user1.email
        fill_in 'user_user_name', with: user1.user_name
        fill_in 'user_password', with: user1.password
        fill_in 'user_password_confirmation', with: ''
      end
      click_button 'Sign up'
      expect(page).to have_text "Password confirmation doesn't match Password"
    end
  end

  context 'when the first user signs up' do
    it 'gives admin role to the first user' do
      visit '/users/sign_up'
      within('#new_user') do
        fill_in 'user_email', with: user1.email
        fill_in 'user_user_name', with: user1.user_name
        fill_in 'user_password', with: user1.password
        fill_in 'user_password_confirmation', with: user1.password_confirmation
      end
      click_button 'Sign up'
      expect(page).to have_text 'Admin'
    end
  end
end
