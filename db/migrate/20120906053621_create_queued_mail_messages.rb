class CreateQueuedMailMessages < ActiveRecord::Migration
  def change
    create_table :queued_mail_messages do |t|
      t.string :subject
      t.binary :body, limit: 30.megabyte
      t.string :recipient_address
      t.string :recipient_name
      t.string :sender_address
      t.string :sender_name
      t.string :reply_to_address
      t.string :reply_to_name
      t.string :content_type
      t.string :mime_version
      t.string :content_transfer_encoding

      t.timestamps
    end
  end
end
