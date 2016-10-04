class User < ApplicationRecord
  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  after_create :assign_default_role
  after_create :generate_auth_token

  belongs_to :dealership

  def generate_auth_token
    loop do
      self.auth_token = Devise.friendly_token
      break self.auth_token unless User.where(auth_token: self.auth_token).first
    end
  end

   def assign_default_role
     self.add_role(:customer) if self.roles.blank?
   end
end
