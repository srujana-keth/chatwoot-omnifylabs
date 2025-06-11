FactoryBot.define do
  factory :ai_agent_copilot_message, class: 'CopilotMessage' do
    account
    user
    copilot_thread { association :ai_agent_copilot_thread }
    message { { content: 'This is a test message' } }
    message_type { 'user' }
  end
end
