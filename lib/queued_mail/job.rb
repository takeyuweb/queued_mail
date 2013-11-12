module QueuedMail
  class Job
    @queue = Rails.application.config.mail_queue_name.to_sym
    
    def self.perform(args)
      retried = 0
      begin
        message = QueuedMail::Message.find(args["message_id"].to_i)
      rescue ActiveRecord::RecordNotFound => e
        if retried < retry_limit
          retried += 1
          sleep retry_interval
          retry
        else
          raise e
        end
      end
      
      message.with_lock do
        mailer.original_email(message).deliver
        message.destroy
      end
    rescue ActiveRecord::RecordNotFound => e
      Rails.logger.error e.message
      # nothing raises
    end

    def self.mailer
      @mailer ||= instance_eval(Rails.application.config.mail_queue_outbound_mailer)
    end

    def self.retry_limit
      Rails.application.config.mail_queue_retry_limit
    end

    def self.retry_interval
      Rails.application.config.mail_queue_retry_interval
    end
  end
end
