FactoryBot.define do
  factory :aiAgent_inbox, class: 'AIAgentInbox' do
    association :aiAgent_topic, factory: :aiAgent_topic
    association :inbox
  end
end
