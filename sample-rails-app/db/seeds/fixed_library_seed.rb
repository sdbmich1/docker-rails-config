#!/usr/bin/env ruby

require "securerandom"
require "base64"

puts "Seeding Libraries without triggering dependent callbacks..."

# Direct SQL to remove existing records
ActiveRecord::Base.connection.execute("DELETE FROM addresses")
ActiveRecord::Base.connection.execute("DELETE FROM library_settings")
ActiveRecord::Base.connection.execute("DELETE FROM libraries")

img1 = "https://bcaf-comic-streaming-titles.s3-us-west-1.amazonaws.com/bcaf-digital-images/San_Francisco_Public_Library_Main_Branch_looking_up-1800.jpg"
img2 = "https://bcaf-comic-streaming-titles.s3-us-west-1.amazonaws.com/bcaf-digital-images/The_Main_Library%2C_San_Francisco%2C_California_LCCN2013630232-1800.jpg"
img3 = "https://bcaf-comic-streaming-titles.s3-us-west-1.amazonaws.com/bcaf-digital-images/sfpl_logo-hi-res.png"

# San Francisco Library
library = Library.new(
  name: "San Francisco Public Library", 
  email: "admin@sfpl.org",
  url: "http://sfpl.libanswers.com/faq/65116", 
  domain: "sfpl",
  access_token: SecureRandom.uuid, 
  access_key: Base64.strict_encode64(SecureRandom.bytes(16)),
  select_image_url: img1,
  login_image_url: img2, 
  logo_url: img3,
  access_url: "api/v1/library_cards"
)
library.save(validate: false)

# Create library setting
LibrarySetting.create!(
  max_item_quantity: 1, 
  max_borrow_quantity: 3, 
  borrow_days: 21,
  library_id: library.id
)

# Create address with polymorphic association
Address.create!(
  street: "100 Larkin Street",
  city: "San Francisco",
  state: "CA",
  zip: "94101",
  addressable_type: "Library",
  addressable_id: library.id
)

# Oakland Library
library2 = Library.new(
  name: "Oakland Public Library", 
  email: "admin@oakpl.org",
  url: "https://oaklandlibrary.org", 
  domain: "oakpl",
  access_token: SecureRandom.uuid, 
  access_key: Base64.strict_encode64(SecureRandom.bytes(16)),
  select_image_url: img1,
  login_image_url: img2, 
  logo_url: img3,
  access_url: "api/v1/library_cards"
)
library2.save(validate: false)

LibrarySetting.create!(
  max_item_quantity: 2, 
  max_borrow_quantity: 5, 
  borrow_days: 14,
  library_id: library2.id
)

Address.create!(
  street: "125 14th Street",
  city: "Oakland",
  state: "CA",
  zip: "94612",
  addressable_type: "Library",
  addressable_id: library2.id
)

# Berkeley Library
library3 = Library.new(
  name: "Berkeley Public Library", 
  email: "admin@berkpl.org",
  url: "https://www.berkeleypubliclibrary.org", 
  domain: "berkpl",
  access_token: SecureRandom.uuid, 
  access_key: Base64.strict_encode64(SecureRandom.bytes(16)),
  select_image_url: img1,
  login_image_url: img2, 
  logo_url: img3,
  access_url: "api/v1/library_cards"
)
library3.save(validate: false)

LibrarySetting.create!(
  max_item_quantity: 3, 
  max_borrow_quantity: 10, 
  borrow_days: 21,
  library_id: library3.id
)

Address.create!(
  street: "2090 Kittredge Street",
  city: "Berkeley",
  state: "CA",
  zip: "94704",
  addressable_type: "Library",
  addressable_id: library3.id
)

puts "Libraries and addresses created successfully." 