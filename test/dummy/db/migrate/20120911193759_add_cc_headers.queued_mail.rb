# This migration comes from queued_mail (originally 20120911192301)
class AddCcHeaders < ActiveRecord::Migration
  def change
    add_column :queued_mail_messages, :cc_addresses, :string
    add_column :queued_mail_messages, :bcc_addresses, :string
  end
end
