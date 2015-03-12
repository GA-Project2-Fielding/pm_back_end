FactoryGirl.define do
  factory :task do
    due_date Faker::Date.forward(365)
    completed false
    priority Faker::Number.number(1)
    title Faker::Lorem.word
    description Faker::Lorem.sentence
    project
  end
end
