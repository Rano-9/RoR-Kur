require 'rails_helper'

describe "Beer page" do
  
  before (:each) do
    FactoryBot.create :style
    FactoryBot.create :user
    FactoryBot.create :brewery
  end

  it "should be empty before beers have been created" do
    
    visit beers_path

    expect(page).to have_content("Beer listing")
    expect(page).to have_content("Number of beers: 0")
  end
  
  
  it "should have listed beers when added" do

    FactoryBot.create :beer
    
    visit beers_path

    expect(page).to have_content("Name: anonymous")
    expect(page).to have_content("Brewery: anonymous")
  end

  it "User can create a beer" do
    sign_in(username: "Pekka", password: "Foobar1")
    
    visit new_beer_path

    fill_in("beer_name", with: "IPAha")
    select('Lager', from: 'beer[style_id]')
    select('anonymous', from: 'beer[brewery_id]')

    expect{
      click_button "Create Beer"
    }.to  change{Beer.count}.from(0).to(1)
    
    
  end

  it "User gets appropriet error message on invalid input" do
    sign_in(username: "Pekka", password: "Foobar1")
    
    visit new_beer_path

    fill_in("beer_name", with: "")
    select('Lager', from: 'beer[style_id]')
    select('anonymous', from: 'beer[brewery_id]')

    click_button "Create Beer"
    expect(page).to have_content("Name can't be blank")

  end

end