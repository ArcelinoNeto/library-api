FactoryBot.define do
  years_old = (
    time = Time.new
    birthdate = Faker::Date.birthday(min_age: 18, max_age: 65)
    time.year - birthdate.year
    )

  factory :author do
    name { Faker::Book.author }
    genre_predominant {  Faker::Gender.binary_type }
    years_old { years_old }
    etc { Faker::GreekPhilosophers.quote }
  end
end
