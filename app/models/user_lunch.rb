class UserLunch < ApplicationRecord
  belongs_to :user
  belongs_to :menu_item, foreign_key: 'first_dish_id'
  belongs_to :menu_item, foreign_key: 'main_dish_id'
  belongs_to :menu_item, foreign_key: 'drink_id'
end
