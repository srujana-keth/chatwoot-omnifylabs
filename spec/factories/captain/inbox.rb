FactoryBot.define do
  factory :aiAgent_inbox, class: 'AIAgentInbox' do
    association :aiAgent_assistant, factory: :aiAgent_assistant
    association :inbox
  end
end
