require 'rails_helper'

describe "Beer" do

  it "when created with name, is added to the system" do
    visit new_beer_path
    fill_in('beer_name', with:'Iso 3')

    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(1)
  end

  it "when created without name, is redirected back"  do
    visit new_beer_path

    click_button('Create Beer')
    expect(current_path).to eq(new_beer_path)
  end

end