class UsersMailer < ApplicationMailer
	def user_destroyed(user)
    @user = user
    mail to: 'vidoc1979@gmail.com', subject: "User - #{@user.email} destroyed"
  end

  def user_edited(user)
    @user = user
    mail to: 'vidoc1979@gmail.com', subject: "User - #{@user.email} edited"
  end
end
