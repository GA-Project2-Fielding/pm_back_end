FactoryGirl.define do
  factory :collaborator do
    role Faker::Lorem.word
    owner false
    user
    project
  end
end
