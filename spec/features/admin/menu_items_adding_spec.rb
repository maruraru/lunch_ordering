require 'rails_helper'

RSpec.describe 'Menu items adding', type: :feature do
  before :each do
    FactoryBot.create(:menu, date: Time.zone.today)
    login_as(FactoryBot.create(:user))
    visit '/menus/edit_current'
  end

  context 'when fields are filled' do
    it 'creates menu item' do
      new_menu_item = FactoryBot.build(:menu_item)
      fill_in 'menu_item_new_name', with: new_menu_item.name
      select new_menu_item.category, from: 'menu_item_category'
      fill_in 'menu_item_price', with: new_menu_item.price
      click_on('Add menu item')
      expect(page).to have_text('Saved')
    end
  end

  context 'when fields are not filled' do
    it 'writes errors and fails creation' do
      click_on('Add menu item')
      expect(page).to have_text("can't be blank")
    end
  end

  context 'when search existed item' do
    before do
      @item = FactoryBot.create(:menu_item, menu: FactoryBot.create(:menu, date: Time.zone.today - 1))
      visit '/menus/edit_current'
    end
    it 'suggests item name' do
      fill_in 'menu_item_name', with: @item.name[0..1]
      expect(page).to have_text(@item.name)
      find('div', text: @item.name).click
      click_on('Add menu item')
      expect(page).to have_text(@item.name)
      expect(page).to have_text(@item.category)
      expect(page).to have_text(@item.price)
    end
  end

  context 'when add item from the day week ago' do
    it 'adds menu items' do
      item = FactoryBot.create(:menu_item, menu: FactoryBot.create(:menu, date: Time.zone.today - 7))
      visit '/menus/edit_current'
      click_on('Add all menu items from last ' + Time.zone.today.strftime('%A').downcase)
      expect(page).to have_text(item.name)
      expect(page).to have_text(item.category)
      expect(page).to have_text(item.price)
    end
  end
end
