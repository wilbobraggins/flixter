class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def create
    @user = User.new(:email)

    if @user.save
      ModelMailer.new_record_notification(@user).deliver_now
      format.html { redirect_to @user }
    end
  end

end
