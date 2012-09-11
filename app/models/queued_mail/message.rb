require 'mail/elements/address'

module QueuedMail
  class Message < ActiveRecord::Base
    attr_accessible :body, :recipient_address, :recipient_name, :reply_to_address, :reply_to_name, :sender_address, :sender_name, :subject, :content_type, :mime_version, :content_transfer_encoding, :bcc_addresses, :cc_adresses

    %w(sender recipient reply_to).each do |key|
      class_eval %Q{
        def formatted_#{key}
          address = Mail::Address.new
          address.address = #{key}_address
          address.display_name = #{key}_name
          address.to_s
        end
      }
    end
  end
end
