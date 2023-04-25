class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'welcome to library-management')

    # variable = Mailjet::Send.create(messages: [{
    #                                   'From' => {
    #                                     'Email' => 'vanshikakumrawat889@outlook.com',
    #                                     'Name' => 'Me'
    #                                   },
    #                                   'To' => [
    #                                     {
    #                                       'Email' => @user.email,
    #                                       'Name' => 'You'
    #                                     }
    #                                   ],
    #                                   'Subject' => 'My first Mailjet Email!',
    #                                   'TextPart' => 'Greetings from Mailjet!',
    #                                   'HTMLPart' => '<h3>Dear passenger 1, welcome to <a href=\'https://www.mailjet.com/\'>Mailjet</a>!</h3><br />May the delivery force be with you!'
    #                                 }])

    # variable.attributes[:messages]
  end
end
