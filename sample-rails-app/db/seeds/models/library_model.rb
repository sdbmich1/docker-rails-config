class Library < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_one :library_setting, dependent: :destroy
  has_many :library_items, dependent: :destroy
  has_many :items, through: :library_items
end 