class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  # after_create :send_admin_mail
  # def send_admin_mail
  #   AdminMailer.send_new_admin_message(self).deliver
  # end       
end
