#!/usr/bin/env ruby

require "faker"

puts "Seeding Users and Memberships..."

# Direct SQL to remove existing records
ActiveRecord::Base.connection.execute("DELETE FROM memberships")
ActiveRecord::Base.connection.execute("DELETE FROM users")

# Get library ids
libraries = Library.all
sf_library = libraries.find_by(domain: "sfpl")
oak_library = libraries.find_by(domain: "oakpl")
berk_library = libraries.find_by(domain: "berkpl")

puts "Creating Users and Memberships..."

user = User.create!(
  first_name: "Sean", 
  last_name: "Brown", 
  password: "setup#123", 
  password_confirmation: "setup#123",
  email: "sdbmich@yahoo.com"
)
Membership.create!(
  user_id: user.id, 
  card_no: "1234567890", 
  library_id: sf_library.id, 
  status: "active"
)

user2 = User.create!(
  first_name: Faker::Name.first_name, 
  last_name: Faker::Name.last_name,
  password: "setup#123", 
  password_confirmation: "setup#123", 
  email: Faker::Internet.email
)
Membership.create!(
  user_id: user2.id, 
  card_no: "2345678901", 
  library_id: sf_library.id, 
  status: "active"
)

user3 = User.create!(
  first_name: Faker::Name.first_name, 
  last_name: Faker::Name.last_name,
  password: "setup#123", 
  password_confirmation: "setup#123", 
  email: Faker::Internet.email
)
Membership.create!(
  user_id: user3.id, 
  card_no: "3456789012", 
  library_id: oak_library.id, 
  status: "active"
)

user4 = User.create!(
  first_name: Faker::Name.first_name, 
  last_name: Faker::Name.last_name,
  password: "setup#123", 
  password_confirmation: "setup#123", 
  email: Faker::Internet.email
)
Membership.create!(
  user_id: user4.id, 
  card_no: "4567890123", 
  library_id: oak_library.id, 
  status: "active"
)

user5 = User.create!(
  first_name: Faker::Name.first_name, 
  last_name: Faker::Name.last_name,
  password: "setup#123", 
  password_confirmation: "setup#123", 
  email: Faker::Internet.email
)
Membership.create!(
  user_id: user5.id, 
  card_no: "5678901234", 
  library_id: berk_library.id, 
  status: "active"
)

user6 = User.create!(
  first_name: Faker::Name.first_name, 
  last_name: Faker::Name.last_name,
  password: "setup#123", 
  password_confirmation: "setup#123", 
  email: Faker::Internet.email
)
Membership.create!(
  user_id: user6.id, 
  card_no: "6789012345", 
  library_id: berk_library.id, 
  status: "active"
)

puts "Users and Memberships created successfully." 