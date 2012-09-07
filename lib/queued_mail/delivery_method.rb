module QueuedMail
  class DeliveryMethod
    def initialize(options)
      @options = options
    end

    def deliver!(mail)
      message = QueuedMail::Message.new(:subject           => mail.subject,
                                        :body              => mail.body.encoded(mail.content_transfer_encoding),
                                        :recipient_address => mail.to.first,
                                        :recipient_name    => mail[:to].display_names.first,
                                        :sender_address    => mail.from.first,
                                        :sender_name       => mail[:from].display_names.first,
                                        :reply_to_address  => mail.reply_to ? mail.reply_to.first : nil,
                                        :reply_to_name     => mail.reply_to ? mail[:reply_to].display_names.first : nil,
                                        :content_type      => mail.content_type,
                                        :mime_version      => mail.mime_version,
                                        :content_transfer_encoding => mail.content_transfer_encoding)
      message.save
      enqueue(message.id)
    end

    private
    def enqueue(message_id)
      service = instance_eval("QueuedMail::Queue::#{ Rails.application.config.mail_queue_service.to_s.camelcase }")
      service.enqueue(message_id)
    end
  end
end
