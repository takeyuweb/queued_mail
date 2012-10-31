module QueuedMail
  class DeliveryMethod
    def initialize(options)
      @options = options
    end

    def deliver!(mail)
      message = QueuedMail::Message.new(:source => mail.to_s)
      message.bcc_addresses = mail[:bcc].to_s if mail.bcc
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
