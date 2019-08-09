require 'rails_helper'

RSpec.describe 'Orders API', type: :request do
  before :each do
    admin = FactoryBot.create(:user)
    @token = admin.authentication_token
  end

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
      get '/api/v1/user_orders', headers: { 'X-USER-TOKEN' => @token }
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns orders details' do
      parsed_body = JSON.parse(response.body)
      expect(parsed_body[0].keys).to match_array(%w[category name price user_name])
    end
  end

  context 'when orders are empty' do
    it 'returns status code 204' do
      get '/api/v1/user_orders', headers: { 'X-USER-TOKEN' => @token }
      expect(response).to have_http_status(204)
    end
  end

  context 'when user token is absent' do
    it 'returns status code 401' do
      get '/api/v1/user_orders'
      expect(response).to have_http_status(401)
    end
  end
end
