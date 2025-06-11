FactoryBot.define do
  factory :ai_agent_copilot_thread, class: 'CopilotThread' do
    account
    user
    title { Faker::Lorem.sentence }
    uuid { SecureRandom.uuid }
  end
end
