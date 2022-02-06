class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, format: URI::MailTo::EMAIL_REGEXP
  attr_accessor :password_confirm
  
  has_many :payment_info
  
  # the authenticate method from devise documentation
  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end

  def admin?
		has_role?(:admin)
	end

  def worker?
		has_role?(:worker)
	end

	def normal?
		has_role?(:normal)
	end

  # require 'bcrypt'
  # def valid_password?(password)
  #   binding.pry
  #   return false if encrypted_password.blank?
  #   bcrypt   = ::BCrypt::Password.new(encrypted_password)
  #   if self.class.pepper.present?
  #     password = "#{password}#{self.class.pepper}"
  #   end
  #   password = ::BCrypt::Engine.hash_secret(password, bcrypt.salt)
  #   Devise.secure_compare(password, encrypted_password)
  # end
end
