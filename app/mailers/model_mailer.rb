class ModelMailer < ApplicationMailer
  default from: "no-reply@bellyfit.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.model_mailer.new_user_notification.subject
  #
  require 'sendgrid-ruby'

  #from = Email.new(email: 'test@example.com')
  #to = Email.new(email: 'test@example.com')
  #subject = 'Sending with SendGrid is Fun'
  #content = Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
  #mail = Mail.new(from, subject, to, content)

  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  puts response.status_code
  puts response.body

  def new_user_notification
    @user = User.find_by(:id => 6)
    mail(to: @user.email, 
         subject: "Welcome User")
  end
end
