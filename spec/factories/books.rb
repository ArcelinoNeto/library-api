FactoryBot.define do
  factory :book do
    title { "MyString" }
    description { "MyString" }
    genre { "MyString" }
    author { nil }
    puclication_date { "MyString" }
    publishing_company { "MyString" }
    etc { "MyString" }
  end
end
