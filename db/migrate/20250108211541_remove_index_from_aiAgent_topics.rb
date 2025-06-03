class RemoveIndexFromAIAgentTopics < ActiveRecord::Migration[7.0]
  def change
    remove_index :aiAgent_topics, [:account_id, :name], if_exists: true
  end
end
