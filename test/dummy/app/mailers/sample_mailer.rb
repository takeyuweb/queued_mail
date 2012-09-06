class SampleMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.sample_mailer.simple.subject
  #
  def simple
    @greeting = "Hi"

    mail to: '"Yuichi Takeuchi" <uzuki05@takeyu-web.com>'
  end
end
