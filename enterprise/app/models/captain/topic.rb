# == Schema Information
#
# Table name: aiAgent_topics
#
#  id          :bigint           not null, primary key
#  config      :jsonb            not null
#  description :string
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :bigint           not null
#
# Indexes
#
#  index_aiAgent_topics_on_account_id  (account_id)
#
class AIAgent::Topic < ApplicationRecord
  include Avatarable

  self.table_name = 'aiAgent_topics'

  belongs_to :account
  has_many :documents, class_name: 'AIAgent::Document', dependent: :destroy_async
  has_many :responses, class_name: 'AIAgent::TopicResponse', dependent: :destroy_async
  has_many :aiAgent_inboxes,
           class_name: 'AIAgentInbox',
           foreign_key: :aiAgent_topic_id,
           dependent: :destroy_async
  has_many :inboxes,
           through: :aiAgent_inboxes
  has_many :messages, as: :sender, dependent: :nullify

  validates :name, presence: true
  validates :description, presence: true
  validates :account_id, presence: true

  scope :ordered, -> { order(created_at: :desc) }

  scope :for_account, ->(account_id) { where(account_id: account_id) }

  def available_name
    name
  end

  def push_event_data
    {
      id: id,
      name: name,
      avatar_url: avatar_url.presence || default_avatar_url,
      description: description,
      created_at: created_at,
      type: 'aiAgent_topic'
    }
  end

  def webhook_data
    {
      id: id,
      name: name,
      avatar_url: avatar_url.presence || default_avatar_url,
      description: description,
      created_at: created_at,
      type: 'aiAgent_topic'
    }
  end

  private

  def default_avatar_url
    "#{ENV.fetch('FRONTEND_URL', nil)}/assets/images/dashboard/aiAgent/logo.svg"
  end
end
