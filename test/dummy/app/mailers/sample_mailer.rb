# -*- coding: utf-8 -*-
class SampleMailer < ActionMailer::Base
  default from: "from@takeyu-web.com", bcc: '"Yuichi Takeuchi" <info@takeyu-web.com>', cc: '"山田 太郎" <hoge@takeyu-web.com>, fuga@takeyu-web.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.sample_mailer.simple.subject
  #
  def simple
    @greeting = "Hi"

    mail to: '"Yuichi Takeuchi" <uzuki05@takeyu-web.com>'
  end

  def multipart_test
    mail to: '"Yuichi Takeuchi" <uzuki05@takeyu-web.com>'
  end

  def attachment_test
    attachments['cat.jpg'] = File.read(File.join(Rails.root, 'file/cat.jpg'))
    mail to: '"Yuichi Takeuchi" <uzuki05@takeyu-web.com>'
  end

  def inline_attachment_test
    attachments.inline['cat.jpg'] = File.read(File.join(Rails.root, 'file/cat.jpg'))
    mail to: '"Yuichi Takeuchi" <uzuki05@takeyu-web.com>'
  end
end
