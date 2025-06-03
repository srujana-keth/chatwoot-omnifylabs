class AddStatusToAIAgentTopicResponses < ActiveRecord::Migration[7.0]
  def change
    add_column :aiAgent_topic_responses, :status, :integer, default: 1, null: false
    add_index :aiAgent_topic_responses, :status
  end
end
