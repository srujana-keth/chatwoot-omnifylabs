FactoryBot.define do
  factory :aiAgent_document, class: 'AIAgent::Document' do
    name { Faker::File.file_name }
    external_link { Faker::Internet.unique.url }
    content { Faker::Lorem.paragraphs.join("\n\n") }
    association :assistant, factory: :aiAgent_assistant
    association :account
  end
end
