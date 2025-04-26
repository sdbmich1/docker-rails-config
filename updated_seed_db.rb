#!/usr/bin/env ruby

require "faker"

puts "Seeding the database..."

puts "Creating BCAF Settings..."
BcafSetting.destroy_all
BcafSetting.create(
  logo_url: "https://bcaf-comic-streaming-titles.s3-us-west-1.amazonaws.com/bcaf-digital-images/bcaf_logo_white-hi-res.png",
  image_url: "https://bcaf-comic-streaming-titles.s3-us-west-1.amazonaws.com/bcaf-digital-images/bcaf_logo_white-hi-res.png",
  slogan: "Your Digital Library Connection",
  tagline: "Access digital comics and more",
  selection_image_url: "https://bcaf-comic-streaming-titles.s3-us-west-1.amazonaws.com/bcaf-digital-images/bcaf_logo_white-hi-res.png"
)

puts "Creating Libraries..."
Library.destroy_all
Address.destroy_all
LibraryCard.destroy_all
img1 = "https://bcaf-comic-streaming-titles.s3-us-west-1.amazonaws.com/bcaf-digital-images/San_Francisco_Public_Library_Main_Branch_looking_up-1800.jpg"
img2 = "https://bcaf-comic-streaming-titles.s3-us-west-1.amazonaws.com/bcaf-digital-images/The_Main_Library%2C_San_Francisco%2C_California_LCCN2013630232-1800.jpg"
img3 = "https://bcaf-comic-streaming-titles.s3-us-west-1.amazonaws.com/bcaf-digital-images/sfpl_logo-hi-res.png"

library = Library.create(
  name: "San Francisco Public Library", 
  email: "admin@sfpl.org",
  url: "http://sfpl.libanswers.com/faq/65116", 
  domain: "sfpl",
  access_token: SecureRandom.uuid, 
  access_key: SecureRandom.base64,
  select_image_url: img1,
  login_image_url: img2, 
  logo_url: img3,
  access_url: "api/v1/library_cards"
)
library.build_library_setting(max_item_quantity: 1, max_borrow_quantity: 3, borrow_days: 21)
library.save

# Create address with direct association
Address.create(
  street: "100 Larkin Street",
  city: "San Francisco",
  state: "CA",
  zip: "94101",
  library_id: library.id
)

library2 = Library.create(
  name: "Oakland Public Library", 
  email: "admin@oakpl.org",
  url: "https://oaklandlibrary.org", 
  domain: "oakpl",
  access_token: SecureRandom.uuid, 
  access_key: SecureRandom.base64,
  select_image_url: img1,
  login_image_url: img2, 
  logo_url: img3,
  access_url: "api/v1/library_cards"
)
library2.build_library_setting(max_item_quantity: 2, max_borrow_quantity: 5, borrow_days: 14)
library2.save

Address.create(
  street: "125 14th Street",
  city: "Oakland",
  state: "CA",
  zip: "94612",
  library_id: library2.id
)

library3 = Library.create(
  name: "Berkeley Public Library", 
  email: "admin@berkpl.org",
  url: "https://www.berkeleypubliclibrary.org", 
  domain: "berkpl",
  access_token: SecureRandom.uuid, 
  access_key: SecureRandom.base64,
  select_image_url: img1,
  login_image_url: img2, 
  logo_url: img3,
  access_url: "api/v1/library_cards"
)
library3.build_library_setting(max_item_quantity: 3, max_borrow_quantity: 10, borrow_days: 21)
library3.save

Address.create(
  street: "2090 Kittredge Street",
  city: "Berkeley",
  state: "CA",
  zip: "94704",
  library_id: library3.id
)

puts "Creating Users..."
Membership.all.destroy_all
User.destroy_all
user = User.create(
  first_name: "Sean", 
  last_name: "Brown", 
  password: "setup#123", 
  password_confirmation: "setup#123",
  email: "sdbmich@yahoo.com"
)
member = Membership.create(user_id: user.id, card_no: "1234567890", library_id: library.id, status: "active")

user2 = User.create(
  first_name: Faker::Name.first_name, 
  last_name: Faker::Name.last_name,
  password: "setup#123", 
  password_confirmation: "setup#123", 
  email: Faker::Internet.email
)
member2 = Membership.create(user_id: user2.id, card_no: "2345678901", library_id: library.id, status: "active")

user3 = User.create(
  first_name: Faker::Name.first_name, 
  last_name: Faker::Name.last_name,
  password: "setup#123", 
  password_confirmation: "setup#123", 
  email: Faker::Internet.email
)
member3 = Membership.create(user_id: user3.id, card_no: "3456789012", library_id: library2.id, status: "active")

user4 = User.create(
  first_name: Faker::Name.first_name, 
  last_name: Faker::Name.last_name,
  password: "setup#123", 
  password_confirmation: "setup#123", 
  email: Faker::Internet.email
)
member4 = Membership.create(user_id: user4.id, card_no: "4567890123", library_id: library2.id, status: "active")

user5 = User.create(
  first_name: Faker::Name.first_name, 
  last_name: Faker::Name.last_name,
  password: "setup#123", 
  password_confirmation: "setup#123", 
  email: Faker::Internet.email
)
member5 = Membership.create(user_id: user5.id, card_no: "5678901234", library_id: library3.id, status: "active")

user6 = User.create(
  first_name: Faker::Name.first_name, 
  last_name: Faker::Name.last_name,
  password: "setup#123", 
  password_confirmation: "setup#123", 
  email: Faker::Internet.email
)
member6 = Membership.create(user_id: user6.id, card_no: "6789012345", library_id: library3.id, status: "active")

puts "Creating Categories..."
Category.destroy_all

categories = [
  { name: "Fiction", description: "Fictional works" },
  { name: "Non-Fiction", description: "Non-fictional works" },
  { name: "Comics", description: "Comic books and graphic novels" },
  { name: "Videos", description: "Video content" },
  { name: "Music", description: "Musical content" }
]

categories.each do |category|
  Category.create(category)
end

puts "Database seeding completed." 