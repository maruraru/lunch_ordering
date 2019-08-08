require 'rails_helper'

RSpec.describe Menu, type: :model do
  it "is valid with valid attributes" do
    expect(FactoryBot.build(:menu)).to be_valid
  end

  it "is not valid without a date" do
    expect(Menu.new).to_not be_valid
  end
end
