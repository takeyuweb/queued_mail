module QueuedMail do
    class DeliverEmailJob
      @queue = :mail_queue

      def self.perform(args)
        message = QueuedMail::Mail.find(args["message_id"])
        message.lock!
        
        QueuedMail::Mailer.original_email(message).deliver
        message.destroy
      end
    end
  end
end
