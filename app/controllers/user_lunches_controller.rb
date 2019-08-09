class UserLunchesController < ApplicationController
  before_action :user_already_make_order

  def new
    @user_lunch = []
    MenuItem::CATEGORIES.size.times do
      @user_lunch << UserLunch.new
    end
    @today_menu_courses = Menu.today_menu.day_menu_dishes_hash
    @dish_categories = MenuItem::CATEGORIES
  end

  def create
    permitted_params = user_lunch_params
    ActiveRecord::Base.transaction do
      MenuItem::CATEGORIES.each do |category|
        if permitted_params[category]
          @user_lunch = current_user.user_lunches.build(permitted_params[category])
          @user_lunch.save!
        else
          raise ActiveRecord::Rollback
        end
      end
    end
  rescue
    redirect_to new_user_lunch_path, alert: 'Order creation failed'
  else
    redirect_to '/', notice: 'Order created successfully'
  end

  private

  def user_lunch_params
    params.require(:user_lunch).permit(first_dish: [:dish_id], main_dish: [:dish_id], drink: [:dish_id])
  end

  def user_already_make_order
    unless UserLunch.where('created_at::date = ?', Menu.today_menu.date).where(user: current_user.id).empty?
      redirect_to '/', alert: 'Today you have already made an order.'
    end
  end
end