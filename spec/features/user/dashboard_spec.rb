require 'rails_helper'

RSpec.describe 'Dashboard', type: :feature do
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

  context 'when on the dashboard' do
    it 'displays last 5 week days' do
      login_as(user1)
      visit '/'
      4.downto(0) do |i|
        expect(page).to have_text((Date.today - i).strftime("%A, %d %b %Y"))
      end
    end
  end

  context 'when click on weekday' do
    it 'displays menu' do
      login_as(user1)
      visit '/'
      page.find('a', text: (Date.today).strftime("%A, %d %b %Y")).click
      expect(page).to have_text('First dish')
      expect(page).to have_text('Main dish')
      expect(page).to have_text('Drink')
      Menu.today_menu.menu_items.each do |item|
        expect(page).to have_text(item.name)
        expect(page).to have_text(item.price)
      end
    end
  end
end