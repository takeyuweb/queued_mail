module QueuedMail
  class DeliverEmailJob
    @queue = Rails.application.config.mail_queue_name.to_sym
    
    def self.perform(args)
      message = QueuedMail::Message.find(args["message_id"])
      return unless message

      message.lock!
      QueuedMail::Mailer.original_email(message).deliver
      message.destroy
    end
  end
end
