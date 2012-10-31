# -*- coding: utf-8 -*-
require 'jpmobile'
class JpSampleMailer < Jpmobile::Mailer::Base
  default from: "from@takeyu-web.com"#, bcc: '"Yuichi Takeuchi" <info@takeyu-web.com>', cc: '"山田 太郎" <hoge@takeyu-web.com>, fuga@takeyu-web.com'
  #default from: "from@takeyu-web.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.sample_mailer.simple.subject
  #
  def simple_test
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

  def jprecipient_test
    mail to: '竹内雄一 <uzuki05@takeyu-web.com>', bcc: '竹内雄一（BCC） <info+bcc@takeyu-web.com>'
  end

end
