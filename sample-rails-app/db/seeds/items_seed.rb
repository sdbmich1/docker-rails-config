#!/usr/bin/env ruby

require "faker"
require "securerandom"

puts "Seeding Items and LibraryItems..."

# Direct SQL to remove existing records
ActiveRecord::Base.connection.execute("DELETE FROM featured_items") if defined?(FeaturedItem)
ActiveRecord::Base.connection.execute("DELETE FROM borrowed_items") if defined?(BorrowedItem)
ActiveRecord::Base.connection.execute("DELETE FROM library_items")
ActiveRecord::Base.connection.execute("DELETE FROM items")

# Create items
puts "Creating Items..."
items = []

10.times do |i|
  items << Item.create!(
    title: "The Avengers #{i+1}",
    description: Faker::Lorem.paragraph,
    publisher_name: "Marvel Comics",
    publish_date: Faker::Date.backward(days: 365),
    amount: 2.99,
    page_count: rand(20..50),
    volume_no: 1,
    age_rating: "T",
    name: "Avengers",
    issue_no: "#{i+1}",
    cover_date: Faker::Date.backward(days: 365),
    cast: "Various",
    writer_team: "Stan Lee",
    pencil_team: "Jack Kirby",
    ink_team: "Various",
    color_team: "Various",
    letter_team: "Various",
    editor_team: "Various",
    cover_art_team: "Jack Kirby",
    cover_url: "https://bcaf-comic-streaming-titles.s3-us-west-1.amazonaws.com/bcaf-digital-images/Accell%2B003-000-titleImg.jpg",
    status: "active",
    item_type: "comic",
    item_type_code: "comic"
  )
end

5.times do |i|
  items << Item.create!(
    title: "Captain America: Sam Wilson #{i+1}",
    description: Faker::Lorem.paragraph,
    publisher_name: "Marvel Comics",
    publish_date: Faker::Date.backward(days: 365),
    amount: 3.99,
    page_count: rand(20..50),
    volume_no: 1,
    age_rating: "T",
    name: "Captain America",
    issue_no: "#{i+1}",
    cover_date: Faker::Date.backward(days: 365),
    cast: "Sam Wilson",
    writer_team: "Nick Spencer",
    pencil_team: "Daniel Acuña",
    ink_team: "Various",
    color_team: "Various",
    letter_team: "Various",
    editor_team: "Various",
    cover_art_team: "Daniel Acuña",
    cover_url: "https://bcaf-comic-streaming-titles.s3-us-west-1.amazonaws.com/bcaf-digital-images/Captain%2BAmerica%2B-%2BSam%2BWilson%2B010-titleImg.jpg",
    status: "active",
    item_type: "comic",
    item_type_code: "comic"
  )
end

5.times do |i|
  items << Item.create!(
    title: "Captain Marvel #{i+1}",
    description: Faker::Lorem.paragraph,
    publisher_name: "Marvel Comics",
    publish_date: Faker::Date.backward(days: 365),
    amount: 3.99,
    page_count: rand(20..50),
    volume_no: 1,
    age_rating: "T",
    name: "Captain Marvel",
    issue_no: "#{i+1}",
    cover_date: Faker::Date.backward(days: 365),
    cast: "Carol Danvers",
    writer_team: "Kelly Sue DeConnick",
    pencil_team: "David Lopez",
    ink_team: "Various",
    color_team: "Various",
    letter_team: "Various",
    editor_team: "Various",
    cover_art_team: "David Lopez",
    cover_url: "https://bcaf-comic-streaming-titles.s3-us-west-1.amazonaws.com/bcaf-digital-images/Captain%2BMarvel%2B(2016)%2B010-000-titleImg.jpg",
    status: "active",
    item_type: "comic",
    item_type_code: "comic"
  )
end

puts "Created #{Item.count} items"

# Associate items with libraries
puts "Creating LibraryItems..."
libraries = Library.all
library_items = []

items.each do |item|
  libraries.each do |library|
    library_items << LibraryItem.create!(
      library_id: library.id,
      item_id: item.id,
      status: "active",
      isbn: SecureRandom.uuid,
      language: "English",
      amount: 0.99
    )
  end
end

puts "Created #{LibraryItem.count} library items"
puts "Items and LibraryItems created successfully." 