module Api::V1
  class UserOrdersController < ApiController
    def index
      result = Menu.today_menu.day_lunches
      if result.ntuples.zero?
        render json: { message: 'There is no orders for today' }, status: :no_content
      else
        render json: result.to_json, status: :ok
      end
    end
  end
end
