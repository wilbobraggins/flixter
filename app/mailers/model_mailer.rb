class ModelMailer < ApplicationMailer
  default from: "no-reply@bellyfit.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.model_mailer.new_user_notification.subject
  #
  require 'sendgrid-ruby'

  def new_user_notification
    @user = User.find_by(:id => 2)
    mail(to: @user.email, 
         subject: "Welcome #{@user.email}")
  end
end
