class RemoveNotNullFromAIAgentDocuments < ActiveRecord::Migration[7.0]
  def change
    change_column_null :aiAgent_documents, :name, true
  end
end
