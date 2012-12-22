class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_accessible :email, :password, :password_confirmation
  has_secure_password

  validates :email, presence: true,
                    uniqueness: true,
                    confirmation: true,
                    format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true
end