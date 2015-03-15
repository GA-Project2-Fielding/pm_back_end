FactoryGirl.define do
  factory :file_location do
    name Faker::Lorem.word
    url Faker::Internet.url
    task
  end
end
