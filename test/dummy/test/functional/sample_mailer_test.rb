require 'test_helper'

class SampleMailerTest < ActionMailer::TestCase
  test "simple" do
    mail = SampleMailer.simple
    assert_equal "Simple", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
