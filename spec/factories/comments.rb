FactoryBot.define do
  factory :comment do
    message { Faker::Lorem.sentence }
    created_by { 1 }
    updated_by { 1 }
  end
end
