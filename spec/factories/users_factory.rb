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
    password_digest "903njkweuhri2u3ewrh874"
    image_url "http://imgur.com/3489274"
    description Faker::Lorem.sentence
    token "kjfnsj4958235njkndskjfh"
  end
end
