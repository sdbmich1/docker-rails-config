#!/usr/bin/env ruby

puts "Seeding Borrowed Items..."

# Clear existing borrowed items
ActiveRecord::Base.connection.execute("DELETE FROM borrowed_items") if defined?(BorrowedItem)

# Get San Francisco Public Library
lib = Library.find_by(domain: 'sfpl')
return puts "San Francisco Public Library not found!" unless lib

# Define function to load borrowed items
def load_borrowed_items(model:, cnt: 10, member:, qty: 1)
  puts "Loading #{cnt} borrowed items for #{model.item.title} by #{member.user.first_name} #{member.user.last_name}"
  cnt.times do |i|
    model.borrowed_items.build(membership: member, status: 'active', quantity: qty)
  end
  model.save
end

# Get library items directly using SQL since the association is missing
library_items = LibraryItem.where(library_id: lib.id).limit(5).to_a
return puts "No library items found!" if library_items.empty?

members = lib.memberships.limit(2).to_a
return puts "No members found!" if members.empty?

# Load borrowed items
puts "Loading borrowed items for the first library item"
load_borrowed_items(
  model: library_items[0],
  member: members[0],
  qty: 3
)

puts "Loading borrowed items for the second library item"
load_borrowed_items(
  model: library_items[1], 
  member: members[0],
  qty: 2
)

puts "Loading borrowed items for the third library item"
load_borrowed_items(
  model: library_items[2], 
  member: members[1],
  cnt: 5,
  qty: 5
)

puts "Loading borrowed items for the fourth library item"
load_borrowed_items(
  model: library_items[3], 
  member: members[0],
  qty: 1
)

puts "Loading borrowed items for the fifth library item"
load_borrowed_items(
  model: library_items[4], 
  member: members[1],
  qty: 4
)

# Count borrowed items
borrowed_items_count = ActiveRecord::Base.connection.select_value("SELECT COUNT(*) FROM borrowed_items")
puts "Created #{borrowed_items_count} borrowed items"
puts "Borrowed Items created successfully." 