module QueuedMail
  class Engine < ::Rails::Engine
    engine_name "queued_mail"
    isolate_namespace QueuedMail

    initializer "queued_mail.add_delivery_method" do |app|
      ActionMailer::Base.add_delivery_method :queued, QueuedMail::DeliveryMethod
      app.config.mail_queue_service = :resque
      app.config.mail_queue_name = :mail_queue
      app.config.mail_queue_outbound_delivery_method = :sendmail
    end
  end
end
