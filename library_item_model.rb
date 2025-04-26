class LibraryItem < ApplicationRecord
  belongs_to :library
  belongs_to :item
  has_many :borrowed_items, dependent: :destroy
  has_many :featured_items, dependent: :destroy
end 