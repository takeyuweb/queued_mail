require 'test_helper'

class SampleMailerTest < ActionMailer::TestCase
  test "simple_test" do
    mail = SampleMailer.simple_test
    assert_equal "Simple", mail.subject
    assert_equal ["uzuki05@takeyu-web.com"], mail.to
    assert_equal ["from@takeyu-web.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
