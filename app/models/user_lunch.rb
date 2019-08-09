class UserLunch < ApplicationRecord
  belongs_to :user
  belongs_to :menu_item, foreign_key: 'dish_id'

  validates_presence_of :menu_item, :user
end
