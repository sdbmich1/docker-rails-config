FactoryBot.define do
  factory :item do
    title { Faker::Book.title }
    name { Faker::Book.title }
    description { Faker::Lorem.paragraph }
    publisher_name { Faker::Book.publisher }
    publish_date { Faker::Date.backward(days: 1000) }
    amount { Faker::Commerce.price(range: 0..100.0) }
    page_count { rand(50..500) }
    volume_no { rand(1..10) }
    age_rating { ['G', 'PG', 'PG-13', 'R', 'NC-17'].sample }
    issue_no { rand(1..100) }
    cover_date { Faker::Date.backward(days: 1000) }
    cast { Faker::Name.name }
    writer_team { Faker::Name.name }
    status { 'active' }
    bcaf_item_number { Faker::Alphanumeric.alphanumeric(number: 10) }
    item_type { ['book', 'comic', 'movie', 'game'].sample }
    item_type_code { Faker::Alphanumeric.alphanumeric(number: 3).upcase }
    image_url { Faker::Internet.url }
  end
end 