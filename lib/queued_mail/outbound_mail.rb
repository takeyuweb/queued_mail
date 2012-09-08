module QueuedMail
  module OutboundMail
    def self.included(klass)
      klass.class_eval do
        self.delivery_method = Rails.application.config.mail_queue_outbound_delivery_method
        layout nil
      end
    end

    def original_email(message)
      mail = mail(:from => message.formatted_sender,
                  :to => message.formatted_recipient,
                  :reply_to => message.formatted_reply_to,
                  :subject => message.subject,
                  :mime_version => message.mime_version,
                  :content_transfer_encoding => message.content_transfer_encoding)
      unless message.content_type.blank?
        mail.header[:content_type].value = Mail::ContentTypeField.new(message.content_type).value
      end
      mail.body = message.body
      mail
    end
  end
end
