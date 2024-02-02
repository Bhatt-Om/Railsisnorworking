class User < ApplicationRecord
  before_create :set_role
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def set_role
    self.role ||= 'student'
  end
  
  def self.authenticate!(email, password)
    user = find_by(email: email) 
    user if user&.valid_password?(password)
  end
end
