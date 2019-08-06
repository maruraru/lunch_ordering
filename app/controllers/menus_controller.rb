class MenusController < ApplicationController

  def index
    @all_days = Menu.all_days
  end

  def edit_current
    @day_menu = Menu.today_menu
    @existed_menu_items = MenuItem.recent_items
  end

  def new
    @menu = Menu.new
  end

  def create
    menu = Menu.new(date: Date.today)
    if menu.save
      redirect_to current_menu_path, notice: 'Saved'
    else
      redirect_to '/', notice: 'Creation failed'
    end
  end

  def show

  end

  private

  def menu_params
    params.require(:menu).permit(menu_items_attributes: [:name, :category, :photo, :price])
  end

end