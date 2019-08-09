class UserLunch < ApplicationRecord
  belongs_to :user
  belongs_to :menu_item, foreign_key: 'dish_id', inverse_of: :user_lunches

  validates :menu_item, :user, presence: true
end
