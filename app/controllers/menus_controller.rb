class MenusController < ApplicationController
  before_action :admin_only!

  def index
    @all_days = Menu.all_days
  end

  def edit_current
    @day_menu = Menu.today_menu
    @menu_item = @day_menu.menu_items.build
    @existed_menu_items = MenuItem.recent_items
    @dish_categories = MenuItem::CATEGORIES
  end

  def create
    menu = Menu.new(date: Date.today)
    if menu.save
      flash.now.notice = "Today's menu created successfully"
      redirect_to current_menu_path
    else
      flash.now.alert = 'Creation failed'
      redirect_to '/'
    end
  end

  def show

  end

end