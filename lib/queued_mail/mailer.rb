module QueuedMail
  class Mailer < ActionMailer::Base
    self.delivery_method = Rails.application.config.mail_queue_outbound_delivery_method
    layout nil

    def original_email(message)
      mail = mail(:from => message.formatted_sender,
                  :to => message.formatted_recipient,
                  :reply_to => message.formatted_reply_to,
                  :subject => message.subject,
                  :content_type => message.content_type,
                  :mime_version => message.mime_version,
                  :content_transfer_encoding => message.content_transfer_encoding)
      
      mail.body = message.body
    end
  end
end
