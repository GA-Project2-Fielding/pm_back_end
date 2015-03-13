FactoryGirl.define do
  factory :user do
    sequence :user_name do |n|
    "user_name#{n}"
    end
    sequence :email do |n|
    "person#{n}@example.com"
    end
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    password Faker::Lorem.word
    image_url "http://imgur.com/3489274"
    description Faker::Lorem.sentence
    token "a47a8e54b11c4de5a4a351734c80a14a"
  end
end
