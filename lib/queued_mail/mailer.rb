module QueuedMail
  class Mailer < ActionMailer::Base
    self.delivery_method = Rails.application.config.mail_queue_outbound_delivery_method
    layout nil

    class << self
      def original_email(message)
        m = new(nil, :raw_source => message.source)
        m.message.bcc = message.bcc_addresses
        m.message
      end
    end

    def initialize(method_name, *args)
      super
      if method_name.nil?
        if args.size == 1 && args.first.is_a?(Hash)
          raw_source = args.first.delete(:raw_source)
          
          if raw_source
            @_message = Mail.new(raw_source)
            wrap_delivery_behavior!
          end
        end
      end
    end
    
  end
end
