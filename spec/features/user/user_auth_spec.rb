# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User.authenticate', type: :feature do
  let!(:user1) { FactoryBot.create(:user) }

  context 'when all fields are filled correctly' do
    it 'logs in' do
      visit '/users/sign_in'
      within('#new_user') do
        fill_in 'user_email', with: user1.email
        fill_in 'user_password', with: user1.password
      end
      click_button 'Sign in'
      expect(page).to have_text 'Signed in successfully.'
    end
  end

  context 'when some fields are incorrect' do
    it 'can not log in with wrong password' do
      visit '/users/sign_in'
      within('#new_user') do
        fill_in 'user_email', with: user1.email
        fill_in 'user_password', with: 'random_word'
      end
      click_button 'Sign in'
      expect(page).to have_text 'Invalid Email or password.'
    end

    it 'can not log in when fields are empty' do
      visit '/users/sign_in'
      within('#new_user') do
        fill_in 'user_email', with: ''
        fill_in 'user_password', with: ''
      end
      click_button 'Sign in'
      expect(page).to have_text 'Invalid Email or password.'
    end
  end
end
