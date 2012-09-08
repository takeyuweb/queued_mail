require 'test_helper'

class JpSampleMailerTest < ActionMailer::TestCase
  test "simple_test" do
    mail = JpSampleMailer.simple_test
    assert_equal "Simple test", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "multipart_test" do
    mail = JpSampleMailer.multipart_test
    assert_equal "Multipart test", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "attachment_test" do
    mail = JpSampleMailer.attachment_test
    assert_equal "Attachment test", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "inline_attachment_test" do
    mail = JpSampleMailer.inline_attachment_test
    assert_equal "Inline attachment test", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
