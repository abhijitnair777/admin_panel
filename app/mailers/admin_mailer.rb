class AdminMailer < ApplicationMailer
  
  def send_new_admin_message(admin_user)
  	@admin_user = admin_user
  	mail to: admin_user.email, subject: "Welcome"
    # mail to: "abnair@bestpeers.com", subject: "Welcome"
  end	
end
