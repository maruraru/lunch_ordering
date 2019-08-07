class UserLunchesController < ApplicationController
  def new
    @user_lunch = UserLunch.new
    load_instance_variables_for_new
  end

  def create
    @user_lunch = current_user.user_lunches.build(user_lunch_params)
    if @user_lunch.save
      flash.now.notice = 'Order created successfully'
      redirect_to '/'
    else
      load_instance_variables_for_new
      flash.now.alert = 'Creation failed'
      render 'new'
    end
  end

  private

  def load_instance_variables_for_new
    @today_menu_courses = Menu.today_menu.day_menu_dishes_hash
    @dish_categories = MenuItem::CATEGORIES
  end

  def user_lunch_params
    params.require(:user_lunch).permit(:first_dish_id, :main_dish_id, :drink_id)
  end
end