module QueuedMail
  class Mailer < ActionMailer::Base
    include QueuedMail::OutboundMail
  end
end
