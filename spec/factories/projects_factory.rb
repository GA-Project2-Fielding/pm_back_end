FactoryGirl.define do

  factory :project do
    project_title Faker::Lorem.word
    description Faker::Lorem.sentence
    start_date Faker::Date.backward(100)
    due_date Faker::Date.forward(365)
    completion_date Faker::Date.backward(100)
    completed false
    visible false

    trait :with_user do
        after(:create) do |project|
        project.users << create(:user)
        end
    end
  end
end

