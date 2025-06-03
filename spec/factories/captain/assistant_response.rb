FactoryBot.define do
  factory :aiAgent_assistant_response, class: 'AIAgent::AssistantResponse' do
    association :assistant, factory: :aiAgent_assistant
    association :account
    sequence(:question) { |n| "Test question #{n}?" }
    sequence(:answer) { |n| "Test answer #{n}" }
    embedding { Array.new(1536) { rand(-1.0..1.0) } }

    trait :with_document do
      association :document, factory: :aiAgent_document
    end
  end
end
