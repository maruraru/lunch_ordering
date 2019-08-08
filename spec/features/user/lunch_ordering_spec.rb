require 'rails_helper'

RSpec.describe 'Lunch order creation', type: :feature do
  before :each do
    menu = FactoryBot.create(:menu, date: Date.today)
    user1 = FactoryBot.create(:user)
    2.times do
      MenuItem::CATEGORIES.each do |category|
        FactoryBot.create(:menu_item, menu: menu, category: category)
      end
    end
    login_as(user1)
    visit '/user_lunches/new'
  end

  context 'when user choose dishes' do
    it 'creates lunch order only once' do
      Menu.today_menu.menu_items.each do |item|
        choose('user_lunch_menu_item_' + item.id.to_s)
      end
      click_on('Submit')
      expect(page).to have_text('Order created successfully')
      visit '/user_lunches/new'
      expect(page).to have_text('Today you have already made an order.')
    end
  end

  context "when user doesn't choose dishes" do
    it "doesn't create lunch order" do
      click_on('Submit')
      expect(page).to have_text('Order creation failed')
    end
  end
end