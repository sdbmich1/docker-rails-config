FactoryBot.define do
  factory :bcaf_setting do
    logo_url { Faker::Internet.url }
    image_url { Faker::Internet.url }
    slogan { Faker::Company.catch_phrase }
    tagline { Faker::Company.bs }
    selection_image_url { Faker::Internet.url }
  end
end 