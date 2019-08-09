class MenusController < ApplicationController
  before_action :admin_only!

  def index
    @all_days = Menu.all_days.order(date: :desc).page params[:page]
  end

  def edit_current
    @day_menu = Menu.today_menu
    @menu_item = @day_menu.menu_items.build
    @existed_menu_items = MenuItem.recent_items
    @dish_categories = MenuItem::CATEGORIES
  end

  def add_last_week_items
    if params[:load_last_week][:load]
      if Menu.today_menu.add_last_week_items
        redirect_to current_menu_path, notice: 'Success'
      else
        redirect_to current_menu_path, alert: 'Empty'
      end
    end
  end

  def show
    @menu = Menu.find(params[:id])
    @dishes_hash = @menu.day_menu_dishes_hash
    @user_lunches = Kaminari.paginate_array(@menu.day_lunches.to_a).page(params[:page]).per(30)
    @lunches_cost = @menu.day_lunches_cost
  end
end
