class Menu < ApplicationRecord
  has_many :menu_items
  accepts_nested_attributes_for :menu_items

  validates :date, presence: true

  def day_menu_dishes_hash
    if menu_items.empty?
      menus = nil
    else
      menus = {}
      MenuItem::CATEGORIES.each do |course|
        menus[course] = menu_items.where(category: course)
      end
    end
    menus
  end

  def day_lunches
    sql = "Select users.user_name, menu_items.name, menu_items.category, menu_items.price
                  FROM (select user_id, dish_id, created_at FROM user_lunches WHERE created_at::date = '#{date}') as first
                  JOIN (select id, user_name from users) as users ON first.user_id = users.id
                  JOIN (select id, name, price, category from menu_items) as menu_items ON first.dish_id = menu_items.id
                  ORDER BY first.created_at"
    ActiveRecord::Base.connection.execute(sql)
  end

  def day_earnings
    sql = "Select SUM(menu_items.price) as total FROM (SELECT dish_id FROM user_lunches WHERE created_at::date = '#{date}') as lunches
                  JOIN (select id, price FROM menu_items) as menu_items ON lunches.dish_id = menu_items.id"
    ActiveRecord::Base.connection.execute(sql)[0]['total']
  end

  def self.all_days
    Menu.select(:id, :date).reverse
  end

  def self.last_days(number = 5)
    Menu.order(date: :asc).limit(number).reverse
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
