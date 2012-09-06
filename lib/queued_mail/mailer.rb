module QueuedMail
  class Mailer < ActionMailer::Base
    self.delivery_method = Rails.application.config.mail_queue_outbound_delivery_method
    layout nil

    def original_email(email)
      mail(:from => email.formatted_sender,
           :to => email.formatted_recipient,
           :reply_to => email.formatted_reply_to,
           :subject => email.subject) do |format|
        format.text { render :text => email.body }
      end
    end
  end
end
