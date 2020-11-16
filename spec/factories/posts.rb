FactoryBot.define do

  factory :post do
    title { Faker::Book.title }
    title_link { Faker::Book.title }
    content { Faker::Lorem.sentence }
    comment_count { 0 }
    created_by { "" }
    updated_by { 1 }
  end
end
