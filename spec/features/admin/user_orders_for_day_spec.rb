require 'rails_helper'

RSpec.describe "User's orders on day page", type: :feature do
  before do
    @menu = FactoryBot.create(:menu)
    @total_price = 0
    @all_values = []
    10.times do
      user = FactoryBot.create(:user)
      @all_values << user.user_name
      MenuItem::CATEGORIES.each do |category|
        item = FactoryBot.create(:menu_item, menu: @menu, category: category)
        @all_values << item.name
        @all_values << item.category
        FactoryBot.create(:user_lunch, user: user, menu_item: item)
        @all_values << item.category
        @total_price += item.price
      end
    end
    login_as(User.find_by(is_admin: true))
    visit '/menus/' + @menu.id.to_s
  end

  context 'when there are lunch orders for the day' do
    it "lists user's orders" do
      expect(page).to have_text(@menu.date.strftime('%d %b %Y'))
      @all_values.each do |value|
        expect(page).to have_text(value)
      end
    end

    it 'display total day lunches cost' do
      expect(page).to have_text('Total cost: ' + @total_price.to_s)
    end
  end
end
