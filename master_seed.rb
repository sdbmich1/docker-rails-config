#!/usr/bin/env ruby

puts "Running master seed file..."

# First, clear out data with foreign key dependencies
puts "Clearing dependent tables..."
ActiveRecord::Base.connection.execute("DELETE FROM borrowed_items") if defined?(BorrowedItem)
ActiveRecord::Base.connection.execute("DELETE FROM featured_items") if defined?(FeaturedItem)
ActiveRecord::Base.connection.execute("DELETE FROM library_items")
ActiveRecord::Base.connection.execute("DELETE FROM items")
ActiveRecord::Base.connection.execute("DELETE FROM categories")
ActiveRecord::Base.connection.execute("DELETE FROM memberships")
ActiveRecord::Base.connection.execute("DELETE FROM users")
ActiveRecord::Base.connection.execute("DELETE FROM addresses")
ActiveRecord::Base.connection.execute("DELETE FROM library_settings")
ActiveRecord::Base.connection.execute("DELETE FROM libraries")

# Load BcafSetting
puts "Loading BcafSetting..."
load Rails.root.join('bcaf_seed.rb')

# Load Libraries
puts "Loading Libraries..."
load Rails.root.join('fixed_library_seed.rb')

# Load Users
puts "Loading Users and Memberships..."
load Rails.root.join('users_seed.rb')

# Load Categories
puts "Loading Categories..."
load Rails.root.join('categories_seed.rb')

# Load Items and LibraryItems
puts "Loading Items and LibraryItems..."
load Rails.root.join('items_seed.rb')

# Load Borrowed Items
puts "Loading Borrowed Items..."
load Rails.root.join('borrowed_items_seed.rb')

puts "Seed complete! Summary of created records:"
puts "- BcafSettings: #{BcafSetting.count}"
puts "- Libraries: #{Library.count}"
puts "- Addresses: #{Address.count}"
puts "- LibrarySettings: #{LibrarySetting.count}"
puts "- Users: #{User.count}"
puts "- Memberships: #{Membership.count}"
puts "- Categories: #{Category.count}"
puts "- Items: #{Item.count}"
puts "- LibraryItems: #{LibraryItem.count}"
puts "- BorrowedItems: #{BorrowedItem.count if defined?(BorrowedItem)}" 