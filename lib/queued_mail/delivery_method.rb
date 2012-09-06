require 'resque'

module QueuedMail
  class DeliveryMethod
    def initialize(*args)
    end

    def deliver!(mail)
      message = QueuedMail::Message.create(:subject           => mail.subject,
                                           :body              => mail.body,
                                           :recipient_address => mail.to.first,
                                           :recipient_name    => mail[:to].display_names.first,
                                           :sender_address    => mail.from.first,
                                           :sender_name       => mail[:from].display_names.first,
                                           :reply_to_address  => mail.reply_to ? mail.reply_to.first : nil,
                                           :reply_to_name     => mail.reply_to ? mail[:reply_to].display_names.first : nil)
      Resque.enqueue(QueuedMail::DeliverEmailJob, :message_id => message.id)
    end
  end
end
