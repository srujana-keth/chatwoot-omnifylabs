class AddContentAttributesToConversations < ActiveRecord::Migration[7.0]
  def change
    add_column :conversations, :content_attributes, :json, default: {}
  end
end
