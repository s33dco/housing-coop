class ApplicationMailer < ActionMailer::Base
  default from: "#{ENV['COOP_EMAIL_ADDRESS']}", subject: "#{ENV['COOP_EMAIL_SUBJECT']}"
  layout 'mailer'
end
