module QueuedMail
  class Mailer < ActionMailer::Base
    self.delivery_method = Rails.application.config.mail_queue_outbound_delivery_method
    layout nil

    def original_email(message)
      mail(:from => message.formatted_sender,
           :to => message.formatted_recipient,
           :reply_to => message.formatted_reply_to,
           :subject => message.subject) do |format|
        format.text { render :text => message.body }
      end
    end
  end
end
