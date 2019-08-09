class DashboardController < ApplicationController
  def index
    @menus = {}
    Menu.last_days(5).each do |day_menu|
      @menus[day_menu] = day_menu.day_menu_dishes_hash
    end
  end
end
