require 'test_helper'

module QueuedMail
  class MessageTest < ActiveSupport::TestCase
    test 'RFC violation' do
      #message = queuedmail_messages(:rfc_violation1)
      message = QueuedMail::Message.new(recipient_address: "to.@takeyu-web.com",
                                        recipient_name: "Recipient")
      assert_equal message.formatted_recipient, 'Recipient <"to."@takeyu-web.com>'
    end
  end
end
