module QueuedMail
  class DeliveryMethod
    def initialize(options)
      @options = options
    end

    def deliver!(mail)
      message = QueuedMail::Message.new(:source => mail.to_s)
      
      addresses = mail.bcc
      if addresses
        message.bcc_addresses = addresses.map{|address| address.to_s.scan(/^.*?([a-zA-Z0-9._+-]+@[a-zA-Z0-9._-]+?)(?![a-zA-Z0-9._-]).*$/).flatten.first }.uniq.compact.join(', ')
      end
        
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
