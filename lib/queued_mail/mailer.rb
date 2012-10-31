module QueuedMail
  class Mailer < ActionMailer::Base
    self.delivery_method = Rails.application.config.mail_queue_outbound_delivery_method
    layout nil

    class << self
      def original_email(message)
        new(nil, :raw_source => message.source, :bcc => message.bcc_addresses).message
      end
    end

    def initialize(method_name, *args)
      super
      if method_name.nil?
        if args.size == 1 && args.first.is_a?(Hash)
          raw_source = args.first.delete(:raw_source)
          
          if raw_source
            @_message = Mail.new(raw_source)
            process(:original_email, *args)
          end
        end
      end
    end
    
    def original_email(options)
      mail(options)
    end

  end
end
