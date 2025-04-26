FactoryBot.define do
  factory :library do
    name { Faker::Company.name }
    email { Faker::Internet.email }
    status { 'active' }
    url { Faker::Internet.url }
    access_token { Faker::Alphanumeric.alphanumeric(number: 20) }
    access_key { Faker::Alphanumeric.alphanumeric(number: 16) }
    access_url { Faker::Internet.url }
    select_image_url { Faker::Internet.url }
    login_image_url { Faker::Internet.url }
    logo_url { Faker::Internet.url }
    domain { Faker::Internet.domain_name }
    pin_url { Faker::Internet.url }
    
    # Add associations as needed in tests
    trait :with_items do
      after(:create) do |library|
        create_list(:library_item, 3, library: library)
      end
    end
  end
end 