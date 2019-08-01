class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_save :check_to_make_admin

  private

  def check_to_make_admin
    # Only the first user should become an admin
    self.is_admin = true if User.count.zero?
  end
end
