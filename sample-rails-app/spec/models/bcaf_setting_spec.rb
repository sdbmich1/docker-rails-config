require 'rails_helper'

RSpec.describe BcafSetting, type: :model do
  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:bcaf_setting)).to be_valid
    end
  end

  describe 'attributes' do
    let(:setting) { create(:bcaf_setting) }
    
    it 'has a logo_url' do
      expect(setting.logo_url).not_to be_nil
    end
    
    it 'has an image_url' do
      expect(setting.image_url).not_to be_nil
    end
    
    it 'has a slogan' do
      expect(setting.slogan).not_to be_nil
    end
    
    it 'has a tagline' do
      expect(setting.tagline).not_to be_nil
    end
    
    it 'has a selection_image_url' do
      expect(setting.selection_image_url).not_to be_nil
    end
  end
end 