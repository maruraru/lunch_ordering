class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, password_length: 6..128
  before_save :check_to_make_admin

  validates :user_name, presence: true, length: { maximum: 50 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP },
                    presence: true, length: { maximum: 50 }

  private

  def check_to_make_admin
    # Only the first user should become an admin
    self.is_admin = true if User.count.zero?
  end
end
