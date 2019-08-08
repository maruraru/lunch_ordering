require 'rails_helper'

RSpec.describe 'Orders API', type: :request do

  context 'when orders are ready' do
    before do
      menu = FactoryBot.create(:menu)
      10.times do
        user = FactoryBot.create(:user)
        MenuItem::CATEGORIES.each do |category|
          item = FactoryBot.create(:menu_item, menu: menu, category: category)
          FactoryBot.create(:user_lunch, user: user, menu_item: item)
        end
      end
      get '/api/v1/user_orders'
    end
    it 'returns orders' do
      expect(response).to have_http_status(200)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body[0].keys).to match_array(%w[category name price user_name])
    end
  end

  context 'when orders are empty' do
    it 'returns empty data' do
      get '/api/v1/user_orders'
      expect(response).to have_http_status(204)
    end
  end
end