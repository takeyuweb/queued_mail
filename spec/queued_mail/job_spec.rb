# -*- coding: utf-8 -*-
require 'spec_helper'

describe QueuedMail::Job do

  describe '#perform' do    

    it "nothing raises" do
      QueuedMail::Message.stub_chain(:lock, :find).and_raise(ActiveRecord::RecordNotFound)
      expect{ QueuedMail::Job.perform('message_id' => 1) }.to_not raise_error
    end

    it "nothing raises" do
      QueuedMail::Message.stub_chain(:lock, :find).and_raise(ActiveRecord::RecordNotFound)
      Rails.logger.should_receive(:error)
      QueuedMail::Job.perform('message_id' => 1)
    end

    it do
      rel = stub('ActiveRecord::Relation')
      QueuedMail::Message.stub_chain(:lock, :find).and_return(stub(QueuedMail::Message).as_null_object)
      QueuedMail::Mailer.should_receive(:original_email).and_return(double(Mail::Message).as_null_object)
      QueuedMail::Job.perform('message_id' => 1)
    end

    it do
      rel = stub('ActiveRecord::Relation')
      mail = double(Mail::Message).as_null_object
      QueuedMail::Message.stub_chain(:lock, :find).and_return(stub(QueuedMail::Message).as_null_object)
      QueuedMail::Mailer.stub(:original_email).and_return(mail)
      mail.should_receive(:deliver)
      QueuedMail::Job.perform('message_id' => 1)
    end

    it do
      rel = stub('ActiveRecord::Relation')
      message = stub(QueuedMail::Message).as_null_object
      QueuedMail::Message.stub_chain(:lock, :find).and_return(message)
      QueuedMail::Mailer.stub(:original_email).and_return(double(Mail::Message).as_null_object)
      message.should_receive(:destroy)
      QueuedMail::Job.perform('message_id' => 1)
    end

    [1, 2, 3].each do |retry_limit|
      context "config.mail_queue_retry_limit = #{retry_limit}" do
        before do
          Rails.application.config.stub(mail_queue_retry_limit: retry_limit,
                                        mail_queue_retry_interval: 0)
        end
        it do
          rel = stub('ActiveRecord::Relation')
          QueuedMail::Message.stub(:lock).and_return(rel)
          rel.should_receive(:find).with(1).exactly(retry_limit + 1).times.and_raise(ActiveRecord::RecordNotFound)
          QueuedMail::Job.perform('message_id' => 1)
        end

        it do
          rel = stub('ActiveRecord::Relation')
          QueuedMail::Message.stub(:lock).and_return(rel)
          rel.should_receive(:find).with(1).exactly(1).times.and_return(stub(QueuedMail::Message).as_null_object)
          QueuedMail::Mailer.stub(:original_email).and_return(double(Mail::Message).as_null_object)
          QueuedMail::Job.perform('message_id' => 1)
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
          QueuedMail::Message.stub_chain(:lock, :find).and_raise(ActiveRecord::RecordNotFound)
          QueuedMail::Job.should_receive(:sleep).with(retry_interval)
          QueuedMail::Job.perform('message_id' => 1)
        end
      end
    end

  end

end
