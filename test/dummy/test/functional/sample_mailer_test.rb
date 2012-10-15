require 'test_helper'

class SampleMailerTest < ActionMailer::TestCase
  test "simple" do
    mail = SampleMailer.simple
    assert_equal "Simple", mail.subject
    assert_equal ["uzuki05@takeyu-web.com"], mail.to
    assert_equal ["from@takeyu-web.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
