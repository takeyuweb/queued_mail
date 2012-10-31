# -*- coding: utf-8 -*-
require 'spec_helper'

describe QueuedMail::Mailer do
  let(:message){ stub_model(QueuedMail::Message, source: file_read('001.eml')) }
  {
    smtp: Mail::SMTP,
    sendmail: Mail::Sendmail
  }.each do |method, klass|
    it 'delivery_method' do
      QueuedMail::Mailer.delivery_method = method
      mail = QueuedMail::Mailer.original_email(message)
      mail.delivery_method.should be_is_a(klass)
    end
  end

  [nil,
   '',
  ].each do |addresses|
    it "BCC addresses(#{addresses.inspect})" do
      message.stub(:bcc_addresses).and_return(addresses)
      QueuedMail::Mailer.original_email(message).bcc.should be_empty
    end
  end
  [
   'hoge@takeyu-web.com, fuga@takeyu-web.com',
  ].each do |addresses|
    it "BCC addresses(#{addresses})" do
      message.stub(:bcc_addresses).and_return(addresses.force_encoding('binary'))
      QueuedMail::Mailer.original_email(message).bcc.should == ['hoge@takeyu-web.com', 'fuga@takeyu-web.com']
    end
  end

end
