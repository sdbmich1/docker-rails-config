#!/usr/bin/env ruby

puts "Seeding BcafSetting..."
BcafSetting.destroy_all
BcafSetting.create(
  logo_url: "https://bcaf-comic-streaming-titles.s3-us-west-1.amazonaws.com/bcaf-digital-images/bcaf_logo_white-hi-res.png",
  image_url: "https://bcaf-comic-streaming-titles.s3-us-west-1.amazonaws.com/bcaf-digital-images/bcaf_logo_white-hi-res.png",
  slogan: "Your Digital Library Connection",
  tagline: "Access digital comics and more",
  selection_image_url: "https://bcaf-comic-streaming-titles.s3-us-west-1.amazonaws.com/bcaf-digital-images/bcaf_logo_white-hi-res.png"
)

puts "BcafSetting created successfully." 