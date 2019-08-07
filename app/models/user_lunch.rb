class UserLunch < ApplicationRecord
  belongs_to :user
  belongs_to :menu_item, foreign_key: 'first_dish_id'
  belongs_to :menu_item, foreign_key: 'main_dish_id'
  belongs_to :menu_item, foreign_key: 'drink_id'

  validates_presence_of :first_dish_id, :main_dish_id, :drink_id
end
