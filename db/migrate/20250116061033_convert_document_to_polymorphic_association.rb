class ConvertDocumentToPolymorphicAssociation < ActiveRecord::Migration[7.0]
  def up
    add_column :ai_agent_topic_responses, :documentable_type, :string

    # rubocop:disable Rails/SkipsModelValidations
    if ChatwootApp.enterprise?
      AiAgent::TopicResponse
        .where
        .not(document_id: nil)
        .update_all(documentable_type: 'AiAgent::Document')
    end
    # rubocop:enable Rails/SkipsModelValidations
    remove_index :ai_agent_topic_responses, :document_id if index_exists?(
      :ai_agent_topic_responses, :document_id
    )

    rename_column :ai_agent_topic_responses, :document_id, :documentable_id
    add_index :ai_agent_topic_responses, [:documentable_id, :documentable_type],
              name: 'idx_cap_asst_resp_on_documentable'
  end

  def down
    if index_exists?(
      :ai_agent_topic_responses, [:documentable_id, :documentable_type], name: 'idx_cap_asst_resp_on_documentable'
    )
      remove_index :ai_agent_topic_responses, name: 'idx_cap_asst_resp_on_documentable'
    end

    rename_column :ai_agent_topic_responses, :documentable_id, :document_id
    remove_column :ai_agent_topic_responses, :documentable_type
    add_index :ai_agent_topic_responses, :document_id unless index_exists?(
      :ai_agent_topic_responses, :document_id
    )
  end
end
