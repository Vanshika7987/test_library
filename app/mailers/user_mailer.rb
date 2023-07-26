class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'welcome to library-management')
  end

  def request_mail(user, book_request)
    @user = user
    @book_request = book_request
    mail(to: @user.email, subject: 'you recieved book request')
  end

  def send_otp(user,otp)
    @user = user
    @otp =otp
    mail(to: @user.email, subject: "otp for login")
  end
end
