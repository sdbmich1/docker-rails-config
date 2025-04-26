require 'rails_helper'

RSpec.describe 'Seed Functionality', type: :model do
  describe 'Library model' do
    it 'can be seeded' do
      library = build(:library)
      expect(library).to be_valid
    end
    
    it 'has the correct associations' do
      library = create(:library)
      item = create(:item)
      
      library_item = LibraryItem.create(
        library: library,
        item: item,
        status: 'available'
      )
      
      expect(library.library_items).to include(library_item)
      expect(library.items).to include(item)
    end
  end
  
  describe 'LibraryItem model' do
    it 'connects libraries and items' do
      library = create(:library)
      item = create(:item)
      
      library_item = LibraryItem.create(
        library: library,
        item: item,
        status: 'checked_out'
      )
      
      expect(library_item.library).to eq(library)
      expect(library_item.item).to eq(item)
      expect(library_item.status).to eq('checked_out')
    end
  end
  
  describe 'Seeds structure' do
    it 'has the required seed files' do
      seed_files = [
        'load_bcaf_settings.rb',
        'load_borrowed_items.rb',
        'load_categories.rb',
        'load_items.rb',
        'load_libraries.rb',
        'load_reports.rb',
        'load_users.rb'
      ]
      
      seed_files.each do |file|
        path = Rails.root.join('db', 'seeds', file)
        expect(File.exist?(path)).to be_truthy
      end
    end
    
    it 'has a main seeds.rb file' do
      path = Rails.root.join('db', 'seeds.rb')
      expect(File.exist?(path)).to be_truthy
    end
  end
end 