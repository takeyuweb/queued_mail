module QueuedMail
  class Job
    @queue = Rails.application.config.mail_queue_name.to_sym
    
    def self.perform(args)
      message = QueuedMail::Message.find(args["message_id"].to_i)
      
      message.lock!
      QueuedMail::Mailer.original_email(message).deliver
      message.destroy
    rescue ActiveRecord::RecordNotFound => e
      # nothing raises
    end
  end
end
