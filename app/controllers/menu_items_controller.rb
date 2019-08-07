class MenuItemsController < ApplicationController
  autocomplete :menu_item, :name, limit: 4,
               extra_data: [:name, :category, :photo, :price]

  before_action :curr_menu, only: %i[create destroy]
  before_action :admin_only!

  def create
    @menu_item = @menu.menu_items.build(menu_item_params)
    if @menu_item.save
      flash.now.notice = 'Saved'
      redirect_to current_menu_path
    else
      @day_menu = Menu.today_menu
      @existed_menu_items = MenuItem.recent_items
      @dish_categories = MenuItem::CATEGORIES
      flash.now.alert = 'Creation failed'
      render 'menus/edit_current'
    end
  end

  def destroy
    menu_item = @menu.menu_items.find(params[:id])
    menu_item.destroy
    redirect_to current_menu_path
  end

  private

  def curr_menu
    @menu = Menu.today_menu
  end

  def menu_item_params
    params.require(:menu_item).permit(:name, :category, :photo, :price)
  end
end