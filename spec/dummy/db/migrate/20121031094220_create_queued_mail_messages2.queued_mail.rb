# This migration comes from queued_mail (originally 20121031151500)
class CreateQueuedMailMessages2 < ActiveRecord::Migration
  def change
    create_table :queued_mail_messages do |t|
      t.binary :source, :limit => 30.megabyte
      t.string :bcc_addresses

      t.timestamps
    end
  end
end
