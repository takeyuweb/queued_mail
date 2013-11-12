# -*- coding: utf-8 -*-
require 'spec_helper'

describe QueuedMail::Job do

  let(:message) do
    message = QueuedMail::Message.create(source: <<'EML')
Message-ID: <5042BF6B.3010600@takeyu-web.com>
Date: Sun, 02 Sep 2012 11:07:39 +0900
From: Yuichi Takeuchi <uzuki05@takeyu-web.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0) Gecko/20120824 Thunderbird/15.0
MIME-Version: 1.0
To: test@takeyu-web.com
Subject: test
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

test
EML
  end

  describe '#perform' do
    let(:mail){ double(Mail::Message).as_null_object }
    before do
      QueuedMail::Mailer.stub(:original_email).and_return(mail)
    end

    it "nothing raises" do
      expect{ QueuedMail::Job.perform('message_id' => message.id) }.to_not raise_error
    end

    it "raises" do
      Rails.logger.should_receive(:error)
      QueuedMail::Job.perform('message_id' => 1)
    end

    it do
      QueuedMail::Mailer.should_receive(:original_email).with(message).and_return(double(Mail::Message).as_null_object)
      QueuedMail::Job.perform('message_id' => message.id)
    end

    it do
      mail.should_receive(:deliver)
      QueuedMail::Job.perform('message_id' => message.id)
    end

    it do
      QueuedMail::Message.stub(:find).and_return(message)
      message.should_receive(:destroy)
      QueuedMail::Job.perform('message_id' => message.id)
    end

    [1, 2, 3].each do |retry_limit|
      context "config.mail_queue_retry_limit = #{retry_limit}" do
        before do
          Rails.application.config.stub(mail_queue_retry_limit: retry_limit,
                                        mail_queue_retry_interval: 0)
          message.stub(:with_lock).and_yield()
        end
        it do
          QueuedMail::Message.should_receive(:find).exactly(retry_limit + 1).times.and_raise(ActiveRecord::RecordNotFound)
          QueuedMail::Job.perform('message_id' => message.id)
        end

        it do
          QueuedMail::Message.should_receive(:find).exactly(1).times.and_return(message)
          QueuedMail::Job.perform('message_id' => message.id)
        end
      end
    end

    [1, 2, 3].each do |retry_interval|
      context "config.mail_queue_retry_interval = #{retry_interval}" do
        before do
          Rails.application.config.stub(mail_queue_retry_limit: 1,
                                        mail_queue_retry_interval: retry_interval)
        end
        it do
          rel = stub('ActiveRecord::Relation')
          QueuedMail::Job.should_receive(:sleep).with(retry_interval)
          QueuedMail::Job.perform('message_id' => 1)
        end
      end
    end

  end

end
