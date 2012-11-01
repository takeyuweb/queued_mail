# -*- coding: utf-8 -*-
require 'spec_helper'

describe QueuedMail::DeliveryMethod, 'deliver!(mail)' do
  
  it 'QueuedMail::Messageオブジェクトが作成されること' do
    mail = ::Mail.new(file_read('001.eml'))
    delivery_method = QueuedMail::DeliveryMethod.new({})
    expect{ delivery_method.deliver!(mail) }.to change(QueuedMail::Message, :count).by(1)
  end

  it 'bccアドレスが設定されること' do
    mail = ::Mail.new(file_read('001.eml'))
    delivery_method = QueuedMail::DeliveryMethod.new({})
    delivery_method.deliver!(mail)
    QueuedMail::Message.last.bcc_addresses.should be_nil
  end

  it 'bccアドレスが設定されること' do
    mail = ::Mail.new(file_read('001.eml'))
    mail.bcc = '竹内雄一 <uzuki05@takeyu-web.com>'
    delivery_method = QueuedMail::DeliveryMethod.new({})
    delivery_method.deliver!(mail)
    QueuedMail::Message.last.bcc_addresses.should == 'uzuki05@takeyu-web.com'
  end

  it 'bccアドレスが設定されること' do
    mail = ::Mail.new(file_read('001.eml'))
    mail.bcc = '竹内雄一 <uzuki05+extend@takeyu-web.com>'
    delivery_method = QueuedMail::DeliveryMethod.new({})
    delivery_method.deliver!(mail)
    QueuedMail::Message.last.bcc_addresses.should == 'uzuki05+extend@takeyu-web.com'
  end

  it 'bccアドレスが設定されること' do
    mail = ::Mail.new(file_read('001.eml'))
    mail.bcc = '竹内雄一 <uzuki05@takeyu-web.com>, hoge@takeyu-web.com'
    delivery_method = QueuedMail::DeliveryMethod.new({})
    delivery_method.deliver!(mail)
    QueuedMail::Message.last.bcc_addresses.should == 'uzuki05@takeyu-web.com, hoge@takeyu-web.com'
  end

  it 'bccアドレスが設定されること' do
    mail = ::Mail.new(file_read('001.eml'))
    mail.bcc = '竹内雄一 <uzuki05+extend@takeyu-web.com>, hoge+extend@takeyu-web.com'
    delivery_method = QueuedMail::DeliveryMethod.new({})
    delivery_method.deliver!(mail)
    QueuedMail::Message.last.bcc_addresses.should == 'uzuki05+extend@takeyu-web.com, hoge+extend@takeyu-web.com'
  end
end
