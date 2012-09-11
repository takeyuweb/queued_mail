class AddCcHeaders < ActiveRecord::Migration
  def change
    add_column :queued_mail_messages, :cc_addresses, :string
    add_column :queued_mail_messages, :bcc_addresses, :string
  end
end
