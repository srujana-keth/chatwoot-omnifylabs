# == Schema Information
#
# Table name: aiAgent_inboxes
#
#  id                   :bigint           not null, primary key
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  aiAgent_assistant_id :bigint           not null
#  inbox_id             :bigint           not null
#
# Indexes
#
#  index_aiAgent_inboxes_on_aiAgent_assistant_id               (aiAgent_assistant_id)
#  index_aiAgent_inboxes_on_aiAgent_assistant_id_and_inbox_id  (aiAgent_assistant_id,inbox_id) UNIQUE
#  index_aiAgent_inboxes_on_inbox_id                           (inbox_id)
#
class AIAgentInbox < ApplicationRecord
  belongs_to :aiAgent_assistant, class_name: 'AIAgent::Assistant'
  belongs_to :inbox

  validates :inbox_id, uniqueness: true
end
