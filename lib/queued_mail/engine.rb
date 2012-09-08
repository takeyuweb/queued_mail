require 'queued_mail/delivery_method'
module QueuedMail
  class Engine < ::Rails::Engine
    engine_name "queued_mail"
    isolate_namespace QueuedMail

    ActionMailer::Base.add_delivery_method :queued, QueuedMail::DeliveryMethod

    # default configurations
    config.mail_queue_service = :resque
    config.mail_queue_name = :mail_queue
    config.mail_queue_outbound_delivery_method = :sendmail
    config.mail_queue_outbound_mailer = 'QueuedMail::Mailer'
  end
end
