# This migration comes from queued_mail (originally 20120906053621)
class CreateQueuedMailMessages < ActiveRecord::Migration
  def change
    create_table :queued_mail_messages do |t|
      t.string :subject
      t.binary :body
      t.string :recipient_address
      t.string :recipient_name
      t.string :sender_address
      t.string :sender_name
      t.string :reply_to_address
      t.string :reply_to_name

      t.timestamps
    end
  end
end
