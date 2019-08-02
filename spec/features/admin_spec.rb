require 'rails_helper'

RSpec.describe 'AdminFeatures', type: :feature do
  let(:user1) { FactoryBot.create(:user) }

  context 'when admin go to all users page' do
    it 'shows all users' do
      login_as(user1)
      visit '/users'
      expect(page).to have_text 'All registered users'
    end
  end
end
