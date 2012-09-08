require "queued_mail/engine"

module QueuedMail
  autoload :DeliveryMethod,  'queued_mail/delivery_method'
  autoload :Mailer,          'queued_mail/mailer'
  autoload :OutboundMail,    'queued_mail/outbound_mail'
  autoload :Job,             'queued_mail/job'

  module Queue
    autoload :Resque,        'queued_mail/queue/resque'
    autoload :AmazonSqs,     'queued_mail/queue/amazon_sqs'
  end
end

