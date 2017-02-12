require 'rails_helper'

RSpec.describe Beer, type: :model do
  
  describe "with proper name and style" do
  	let(:beer){ Beer.create name:"Iso 3", style:"Lager" }

  	it "is saved" do
  		expect(beer).to be_valid
  		expect(Beer.count).to eq(1)
  	end
  end

  it "is not saved without proper name" do
  	beer = Beer.create style:"Lager"

  	expect(beer).not_to be_valid
  	expect(Beer.count).to eq(0)
  end

  it "is not saved without proper style"  do
  	beer = Beer.create name:"Iso 3"

  	expect(beer).not_to be_valid
  	expect(Beer.count).to eq(0)
  end
end
