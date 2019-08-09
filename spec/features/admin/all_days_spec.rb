require 'rails_helper'

RSpec.describe 'All days', type: :feature do
  let(:user1) { FactoryBot.create(:user) }
  before :each do
    6.downto(0) do |i|
      menu = FactoryBot.create(:menu, date: Date.today - i)
      2.times do
        MenuItem::CATEGORIES.each do |category|
          FactoryBot.create(:menu_item, menu: menu, category: category)
        end
      end
    end
  end

  context 'when there are past days' do
    it 'lists days' do
      login_as(user1)
      visit '/menus'
      6.downto(0) do |i|
        expect(page).to have_text((Date.today - i).strftime("%d %b %Y"))
      end
    end
  end
end