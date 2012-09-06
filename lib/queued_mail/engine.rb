module QueuedMail
  class Engine < ::Rails::Engine
    engine_name "queued_mail"
    isolate_namespace QueuedMail

    initializer "queued_mail.add_delivery_method" do
      require 'queued_mail/deliver_email_job'
      require 'queued_mail/delivery_method'
      require 'queued_mail/mailer'
      
      ActionMailer::Base.add_delivery_method :queued, QueuedMail::DeliveryMethod
    end
  end
end
