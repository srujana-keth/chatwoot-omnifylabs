class AddStatusToAIAgentDocuments < ActiveRecord::Migration[7.0]
  def change
    add_column :aiAgent_documents, :status, :integer, null: false, default: 0
    add_index :aiAgent_documents, :status
  end
end
