#!/usr/bin/env ruby

puts "Seeding Categories..."

# Direct SQL to remove existing records
ActiveRecord::Base.connection.execute("DELETE FROM categories")

# Get library IDs
sf_library = Library.find_by(domain: "sfpl")

categories = [
  { name: "Fiction", code: "FIC", item_type_code: "book", library_id: sf_library.id, amount: 0 },
  { name: "Non-Fiction", code: "NFIC", item_type_code: "book", library_id: sf_library.id, amount: 0 },
  { name: "Comics", code: "COMIC", item_type_code: "comic", library_id: sf_library.id, amount: 0 },
  { name: "Videos", code: "VIDEO", item_type_code: "video", library_id: sf_library.id, amount: 0 },
  { name: "Music", code: "MUSIC", item_type_code: "audio", library_id: sf_library.id, amount: 0 }
]

categories.each do |category|
  Category.create!(category)
end

puts "Categories created successfully." 