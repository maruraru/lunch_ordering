class MenuItem < ApplicationRecord
  has_many :user_lunches
  belongs_to :menu

  def self.recent_items(number = 100)
    MenuItem.order(created_at: :asc).select(:id, :name, :category, :photo, :price).last(number)
  end
end
