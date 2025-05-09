require 'rails_helper'

describe "Places" do

  it "if none is returned by the API, it shows proper error" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ ]
    )

    visit places_path
    fill_in("city", with: "kumpula")
    click_button "Search"

    expect(page).to have_content("No locations in kumpula")
  end

  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple are returned by API, it shows them at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ),
        Place.new( name: "Monttu", id: 2 ) ]
    )

    visit places_path
    fill_in('city', with: "kumpula")
    click_button "Search"

    expect(page).to have_content "Monttu"
    expect(page).to have_content "Oljenkorsi"
  end

end