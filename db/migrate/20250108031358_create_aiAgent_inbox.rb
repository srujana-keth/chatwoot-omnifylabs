class CreateAIAgentInbox < ActiveRecord::Migration[7.0]
  def change
    create_table :aiAgent_inboxes do |t|
      t.references :aiAgent_assistant, null: false
      t.references :inbox, null: false
      t.timestamps
    end

    add_index :aiAgent_inboxes, [:aiAgent_assistant_id, :inbox_id], unique: true
  end
end
