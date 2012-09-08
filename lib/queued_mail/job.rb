module QueuedMail
  class Job
    @queue = Rails.application.config.mail_queue_name.to_sym
    
    def self.perform(args)
      message = QueuedMail::Message.find(args["message_id"].to_i)
      
      message.lock!
      mailer.original_email(message).deliver
      message.destroy
    rescue ActiveRecord::RecordNotFound => e
      # nothing raises
    end

    def self.mailer
      @mailer ||= instance_eval(Rails.application.config.mail_queue_outbound_mailer)
    end
  end
end
