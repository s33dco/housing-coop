class MessageMailer < ApplicationMailer

  def contact(message)
  	@greeting = message.name
    @body = message.body
    mail(to: "#{ENV['COOP_EMAIL_ADDRESS']}", from: message.email)
  end
end
