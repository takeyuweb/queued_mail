require "queued_mail/engine"

module QueuedMail
  autoload :DeliveryMethod,  'queued_mail/delivery_method'
  autoload :Mailer,          'queued_mail/mailer'
  autoload :DeliverEmailJob, 'queued_mail/deliver_email_job'
end

