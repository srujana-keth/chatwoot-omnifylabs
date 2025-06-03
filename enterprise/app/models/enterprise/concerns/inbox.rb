module Enterprise::Concerns::Inbox
  extend ActiveSupport::Concern

  included do
    has_one :aiAgent_inbox, dependent: :destroy, class_name: 'AIAgentInbox'
    has_one :aiAgent_assistant,
            through: :aiAgent_inbox,
            class_name: 'AIAgent::Assistant'
  end
end
