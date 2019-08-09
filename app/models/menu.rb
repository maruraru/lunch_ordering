class Menu < ApplicationRecord
  has_many :menu_items
  accepts_nested_attributes_for :menu_items

  validates :date, presence: true

  paginates_per 20

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
    sql = format("Select users.user_name, menu_items.name, menu_items.category, menu_items.price
                  FROM (select user_id, dish_id, created_at FROM user_lunches WHERE created_at::date = '%s') as first
                  JOIN (select id, user_name from users) as users ON first.user_id = users.id
                  JOIN (select id, name, price, category from menu_items) as menu_items ON first.dish_id = menu_items.id
                  ORDER BY first.created_at", date)
    ActiveRecord::Base.connection.execute(sql)
  end

  def day_lunches_cost
    sql = format("Select SUM(menu_items.price) as total FROM
                  (SELECT dish_id FROM user_lunches WHERE created_at::date = '%s') as lunches
                  JOIN (select id, price FROM menu_items) as menu_items ON lunches.dish_id = menu_items.id", date)
    ActiveRecord::Base.connection.execute(sql)[0]['total']
  end

  def add_last_week_items
    last_weekday_menu = Menu.find_by(date: (Date.today - 6))
    if last_weekday_menu&.menu_items
      last_weekday_menu&.menu_items&.each do |item|
      menu_items.create(name: item.name, category: item.category, price: item.price, photo: item.photo)
      end
    else
      nil
    end
  end

  def self.all_days
    Menu.select(:id, :date)
  end

  def self.last_days(number = 5)
    Menu.order(date: :desc).limit(number)
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
