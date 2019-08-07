class MenuItem < ApplicationRecord
  has_many :user_lunches
  belongs_to :menu

  CATEGORIES = %w[first_dish main_dish drink].freeze
  
  validates :name, presence: true, length: { maximum: 100 }
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1, less_than: 1_000_000 }

  def to_label
    name.to_s + ', price: ' + price.to_s + '$'
  end

  def self.recent_items(number = 100)
    MenuItem.order(created_at: :asc).select(:id, :name, :category, :photo, :price).last(number)
  end
end
