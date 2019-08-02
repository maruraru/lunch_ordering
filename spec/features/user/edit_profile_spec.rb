require 'rails_helper'

RSpec.describe 'UserEditProfile', type: :feature do
  let(:user1) { FactoryBot.create(:user) }

  context 'when all fields are correct' do
    it 'changes the email' do
      login_as(user1)
      visit '/users/edit'
      within('#edit_user') do
        fill_in 'user_email', with: Faker::Lorem.character + user1.email
        fill_in 'user_current_password', with: user1.password
      end
      click_button 'Update'
      expect(page).to have_text 'updated successfully'
    end

    it 'changes the user_name' do
      login_as(user1)
      visit '/users/edit'
      within('#edit_user') do
        fill_in 'user_user_name', with: Faker::Lorem.character + user1.user_name
        fill_in 'user_current_password', with: user1.password
      end
      click_button 'Update'
      expect(page).to have_text 'updated successfully'
    end

    it 'changes the password' do
      login_as(user1)
      visit '/users/edit'
      within('#edit_user') do
        new_password = Faker::Lorem.character + user1.password
        fill_in 'user_password', with: new_password
        fill_in 'user_password_confirmation', with: new_password
        fill_in 'user_current_password', with: user1.password
      end
      click_button 'Update'
      expect(page).to have_text 'updated successfully'
    end
  end

  context 'when some fields are invalid' do
    it 'fails if email is not unique' do
      user2 = FactoryBot.create(:user)
      login_as(user1)
      visit '/users/edit'
      within('#edit_user') do
        fill_in 'user_email', with: user2.email
        fill_in 'user_password', with: user1.password
      end
      click_button 'Update'
      expect(page).to have_text 'Email has already been taken'
    end

    it 'fails if email is empty' do
      login_as(user1)
      visit '/users/edit'
      within('#edit_user') do
        fill_in 'user_email', with: ''
        fill_in 'user_password', with: user1.password
      end
      click_button 'Update'
      expect(page).to have_text "can't be blank"
    end

    it 'fails if password is invalid' do
      login_as(user1)
      visit '/users/edit'
      within('#edit_user') do
        fill_in 'user_email', with: user1.email
        fill_in 'user_password', with: Faker::Lorem.characters(8)
      end
      click_button 'Update'
      expect(page).to have_text 'error'
    end

    it 'fails if password confirmation is incorrect' do
      login_as(user1)
      visit '/users/edit'
      within('#edit_user') do
        fill_in 'user_password', with: user1.password + Faker::Lorem.character
        fill_in 'user_password_confirmation', with: user1.password
      end
      click_button 'Update'
      expect(page).to have_text "Password confirmation doesn't match Password"
    end
  end
end
