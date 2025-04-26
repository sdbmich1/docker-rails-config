#!/usr/bin/env ruby

require "securerandom"
require "base64"

puts "Seeding database with minimal seed..."

# Create BcafSetting
puts "Creating BcafSetting..."
BcafSetting.delete_all
BcafSetting.create!(
  logo_url: "https://bcaf-comic-streaming-titles.s3-us-west-1.amazonaws.com/bcaf-digital-images/bcaf_logo_white-hi-res.png",
  image_url: "https://bcaf-comic-streaming-titles.s3-us-west-1.amazonaws.com/bcaf-digital-images/bcaf_logo_white-hi-res.png",
  slogan: "Your Digital Library Connection",
  tagline: "Access digital comics and more",
  selection_image_url: "https://bcaf-comic-streaming-titles.s3-us-west-1.amazonaws.com/bcaf-digital-images/bcaf_logo_white-hi-res.png"
)

puts "Done!" 