class AddStatusToAIAgentAssistantResponses < ActiveRecord::Migration[7.0]
  def change
    add_column :aiAgent_assistant_responses, :status, :integer, default: 1, null: false
    add_index :aiAgent_assistant_responses, :status
  end
end
