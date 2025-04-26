#!/usr/bin/env ruby

require "securerandom"
require "base64"

puts "Seeding Libraries..."
Library.destroy_all

img1 = "https://bcaf-comic-streaming-titles.s3-us-west-1.amazonaws.com/bcaf-digital-images/San_Francisco_Public_Library_Main_Branch_looking_up-1800.jpg"
img2 = "https://bcaf-comic-streaming-titles.s3-us-west-1.amazonaws.com/bcaf-digital-images/The_Main_Library%2C_San_Francisco%2C_California_LCCN2013630232-1800.jpg"
img3 = "https://bcaf-comic-streaming-titles.s3-us-west-1.amazonaws.com/bcaf-digital-images/sfpl_logo-hi-res.png"

library = Library.create(
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
library.build_library_setting(max_item_quantity: 1, max_borrow_quantity: 3, borrow_days: 21)
library.save

library2 = Library.create(
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
library2.build_library_setting(max_item_quantity: 2, max_borrow_quantity: 5, borrow_days: 14)
library2.save

library3 = Library.create(
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
library3.build_library_setting(max_item_quantity: 3, max_borrow_quantity: 10, borrow_days: 21)
library3.save

puts "Libraries created successfully." 