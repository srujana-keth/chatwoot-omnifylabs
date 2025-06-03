module Enterprise::Concerns::Account
  extend ActiveSupport::Concern

  included do
    has_many :sla_policies, dependent: :destroy_async
    has_many :applied_slas, dependent: :destroy_async
    has_many :custom_roles, dependent: :destroy_async

    has_many :aiAgent_assistants, dependent: :destroy_async, class_name: 'AIAgent::Assistant'
    has_many :aiAgent_assistant_responses, dependent: :destroy_async, class_name: 'AIAgent::AssistantResponse'
    has_many :aiAgent_documents, dependent: :destroy_async, class_name: 'AIAgent::Document'

    has_many :copilot_threads, dependent: :destroy_async
  end
end
