require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe "With proper brewery beer" do
    let(:test_brewery) { Brewery.new name: "test", year: 2000 }
    it "can be saved" do
      style = FactoryBot.create :style
      beer = Beer.create name: "testbeer", style:style, brewery: test_brewery

      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end

    it "cannot be saved without name" do
      style = FactoryBot.create :style
      beer = Beer.create name: nil, style:style, brewery: test_brewery

      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)

    end

    it "cannot be saved without style" do
      beer = Beer.create name: "testbeer", style: nil, brewery: test_brewery
      
      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end
  end
end
