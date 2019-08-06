class Menu < ApplicationRecord
  has_many :menu_items
  accepts_nested_attributes_for :menu_items

  def self.all_days
    Menu.select(:id, :date)
  end

  def self.day_menu(selected_day)
    Menu.find(date: selected_day).first.menu_items
  end

  def self.day_lunches(selected_day)
    lunches = []
    day_menu(selected_day).each do |menu_item|
      lunches << menu_item.user_lunches
    end
    lunches
  end

  def self.today_menu
    current_menu = Menu.find_by(date: Date.today)
    unless current_menu
      current_menu = Menu.new(date: Date.today)
      current_menu.save
    end
    current_menu
  end
end
