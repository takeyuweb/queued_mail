require "queued_mail/engine"

module QueuedMail
  autoload :DeliveryMethod,  'queued_mail/delivery_method'
  autoload :Mailer,          'queued_mail/mailer'

  module Queue
    autoload :Resque,        'queued_mail/queue/resque'
    autoload :AmazonSqs,     'queued_mail/queue/amazon_sqs'
  end
end

