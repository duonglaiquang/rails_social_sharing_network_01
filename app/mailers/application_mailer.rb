class ApplicationMailer < ActionMailer::Base
  default from: ENV["DEFAULT_MAIL"]
  layout "mailer"
end
