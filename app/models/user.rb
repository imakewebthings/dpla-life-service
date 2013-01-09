# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  password_digest :string(255)
#  token           :string(255)
#

class User < ActiveRecord::Base
  include ActiveModel::SecurePassword::InstanceMethodsOnActivation

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_reader :password
  attr_accessible :password, :password_confirmation, :email
  
  before_create :generate_token

  validates :email, presence: true,
                    uniqueness: true,
                    confirmation: true,
                    format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true,
                       length: { minimum: 8 },
                       on: :create,
                       confirmation: true

  def generate_token
    begin
      self.token = SecureRandom.hex
    end while self.class.exists?(token: token)
  end
end
