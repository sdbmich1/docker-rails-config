require 'rails_helper'

RSpec.describe Library, type: :model do
  describe 'associations' do
    it { should have_many(:memberships).dependent(:destroy) }
    # Commented out until Address model is properly set up with library_id
    # it { should have_many(:addresses).dependent(:destroy) }
    it { should have_one(:library_setting).dependent(:destroy) }
    it { should have_many(:library_items).dependent(:destroy) }
    it { should have_many(:items).through(:library_items) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:library)).to be_valid
    end
  end

  describe 'instance methods' do
    let(:library) { create(:library) }
    let(:item) { create(:item) }

    context 'when adding items to library' do
      it 'successfully creates library items' do
        expect {
          library.library_items.create(item: item, status: 'available')
        }.to change(library.library_items, :count).by(1)
      end
    end
  end
end 