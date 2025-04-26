#!/usr/bin/env ruby

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Load all seed files in the seeds directory
puts "Loading seed files..."

# Load in a specific order to handle dependencies
puts "Loading Users..."
load File.join(Rails.root, 'db', 'seeds', 'load_users.rb')

puts "Loading BCAF Settings..."
load File.join(Rails.root, 'db', 'seeds', 'load_bcaf_settings.rb')

puts "Loading Libraries..."
load File.join(Rails.root, 'db', 'seeds', 'load_libraries.rb')

puts "Loading Categories..."
load File.join(Rails.root, 'db', 'seeds', 'load_categories.rb')

puts "Loading Items..."
load File.join(Rails.root, 'db', 'seeds', 'load_items.rb')

puts "Loading Borrowed Items..."
load File.join(Rails.root, 'db', 'seeds', 'load_borrowed_items.rb')

puts "Loading Reports..."
load File.join(Rails.root, 'db', 'seeds', 'load_reports.rb')

# Load the master seed file
puts "Loading master seed..."
load Rails.root.join('db', 'seeds', 'master_seed.rb')
puts "Master seed loaded successfully."

puts "Database seeding completed." 