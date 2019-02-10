class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def create
    @user = User.new(:email)

    if @user.save
      ModelMailer.new_user_notification(@user).deliver
      format.html { redirect_to @user }
    end
  end

end
