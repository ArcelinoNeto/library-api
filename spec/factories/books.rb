FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    description { Faker::Marketing.buzzwords }
    genre { Faker::Book.genre }
    association(:author)
    puclication_date { Faker::Date.birthday(min_age: 1, max_age: 65) }
    publishing_company { Faker::Book.publisher }
    etc { Faker::GreekPhilosophers.quote }
  end
end
