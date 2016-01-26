class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  has_many :events

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, 	presence: true, length: {maximum: 255 },
  				     	format: { with: VALID_EMAIL_REGEX },
  				     	uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true, length: { minimum: 6}
  has_secure_password
end
