FactoryBot.define do
  factory :library_item do
    association :library
    association :item
    status { 'available' }
    amount { Faker::Number.decimal(l_digits: 2) }
    isbn { Faker::Code.isbn }
    language { Faker::Nation.language }
    last_marc_date { Faker::Date.backward(days: 30) }
    item_type { Faker::Book.genre }
    item_type_code { Faker::Alphanumeric.alphanumeric(number: 3).upcase }
  end
end 