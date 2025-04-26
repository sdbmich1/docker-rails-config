require 'rails_helper'

RSpec.describe LibraryItem, type: :model do
  describe 'associations' do
    it { should belong_to(:library) }
    it { should belong_to(:item) }
    it { should have_many(:borrowed_items).dependent(:destroy) }
    # Commented out until FeaturedItem model is created
    # it { should have_many(:featured_items).dependent(:destroy) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      item = create(:item)
      library = create(:library)
      expect(build(:library_item, item: item, library: library)).to be_valid
    end
  end

  describe 'status' do
    let(:library) { create(:library) }
    let(:item) { create(:item) }
    let(:library_item) { create(:library_item, library: library, item: item, status: 'available') }
    
    it 'can be available' do
      expect(library_item.status).to eq('available')
    end
    
    it 'can be marked as unavailable' do
      library_item.update(status: 'unavailable')
      expect(library_item.status).to eq('unavailable')
    end
  end
end 