require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  let(:test_item) { FactoryBot.create(:menu_item, menu: FactoryBot.create(:menu)) }

  it 'is valid with valid attributes' do
    expect(test_item).to be_valid
  end

  context 'is not valid without some attributes' do
    it 'is not valid without name' do
      test_item.name = ''
      expect(test_item).to_not be_valid
    end

    it 'is not valid without category' do
      test_item.category = ''
      expect(test_item).to_not be_valid
    end

    it 'is not valid without price' do
      test_item.price = ''
      expect(test_item).to_not be_valid
    end
  end
end
