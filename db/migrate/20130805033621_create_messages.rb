class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :sent_id
      t.integer :chat_id
      t.timestamps
    end
  end
end
