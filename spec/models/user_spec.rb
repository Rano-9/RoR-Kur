require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username: "Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username: "Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved without a proper password" do

    user = User.create username: "Pekka", password: "test", password_confirmation: "test"
    expect(user).not_to be_valid
    
    user2 = User.create username: "Pekka", password: "T3s", password_confirmation: "T3s"
    expect(user2).not_to be_valid

    expect(User.count).to eq(0)

  end

  describe "with a proper password" do
    let(:user) { FactoryBot.create(:user) }
  
    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end
  
    it "and with two ratings, has the correct average rating" do
      FactoryBot.create(:rating, score: 10, user: user)
      FactoryBot.create(:rating, score: 20, user: user)
  
      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user){ FactoryBot.create(:user) }
  
    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end
  
    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)
    
      expect(user.favorite_beer).to eq(beer)
    end


    it "is the one with highest rating if several rated" do
      create_beers_with_many_ratings({user: user}, 10, 20, 15, 7, 9)
      best = create_beer_with_rating({ user: user }, 25 )

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "Favorite style" do
    
    before (:each) do
      style1 = FactoryBot.create :style
      style2 = FactoryBot.create :style, name: "NOT IPA"
      style3 = FactoryBot.create :style, name: "IPA"
      
    end

    it "method exists" do
      user = FactoryBot.create(:user)
      expect(user).to respond_to(:favorite_style)
    end

    it "gives favorite_style from 1 rated beer" do
      user = FactoryBot.create(:user)
      create_beers_with_many_ratings({user: user}, 10)

      expect(user.favorite_style.name).to eq("Lager")
    end

    it "gives favorite_style from 2 rated beers" do
      user = FactoryBot.create(:user)
      create_beer_with_rating({user: user}, 10)
      style4 = FactoryBot.create :style, name: "Not_lager"
      beer = FactoryBot.create(:beer, style: style4)
      create_beer_with_rating_style({user: user, beer: beer}, 50)
      expect(user.favorite_style.name).to eq("Not_lager")
    end

    it "gives favorite_style from highest average rated beers" do

      user = FactoryBot.create(:user)
      create_beers_with_many_ratings({user: user}, 2,50,50,50) # average 41.66
      style = FactoryBot.create :style, name: "really no lager"
      beer = FactoryBot.create(:beer, style: style)
      create_beers_with_many_ratings_style({user: user, beer: beer}, 3,50,50,40) # average 39
      style = FactoryBot.create :style, name: "really not lager"
      beer = FactoryBot.create(:beer, style: style)
      create_beers_with_many_ratings_style({user: user, beer: beer}, 1,50,50,50) # average 39.8
      style = FactoryBot.create :style, name: "Not_lager"
      beer = FactoryBot.create(:beer, style: style)
      create_beers_with_many_ratings_style({user: user, beer: beer}, 50,50,50,1) # average 37,75
      expect(user.favorite_style.name).to eq("Lager")
    end

  end

  describe "Favorite brewery" do
    it "method exists" do
      user = FactoryBot.create(:user)
      expect(user).to respond_to(:favorite_brewery)
    end

    it "gives favorite brewery from 1 rated beer" do
      user = FactoryBot.create(:user)
      create_beers_with_many_ratings({user: user}, 10)

      expect(user.favorite_brewery).to eq("anonymous")
    end

    it "gives favorite brewery from 2 rated beers" do
      user = FactoryBot.create(:user)
      create_beers_with_many_ratings({user: user}, 10)
      
      brewery = FactoryBot.create(:brewery, name: "Brewery")
      beer = FactoryBot.create(:beer, brewery: brewery)
      create_beers_with_many_ratings_style({user: user, beer: beer}, 39) # average 39

      expect(user.favorite_brewery).to eq("Brewery")
    end

    it "gives favorite brewery from 3 rated beers" do
      user = FactoryBot.create(:user)
      create_beers_with_many_ratings({user: user}, 50,20,20,20)
      
      brewery = FactoryBot.create(:brewery, name: "Brewery")
      beer = FactoryBot.create(:beer, brewery: brewery)
      create_beers_with_many_ratings_style({user: user, beer: beer}, 50,50,40,50) # average 39

      brewery = FactoryBot.create(:brewery, name: "Brewery2")
      beer = FactoryBot.create(:beer, brewery: brewery)
      create_beers_with_many_ratings_style({user: user, beer: beer}, 50,50,30,50) # average 39

      expect(user.favorite_brewery).to eq("Brewery")
    end

  end

end

def create_beer_with_rating(object, score)
  beer = FactoryBot.create(:beer)
  FactoryBot.create(:rating, beer: beer, score: score, user: object[:user] )
  beer
end

def create_beer_with_rating_style(object, score)
  beer = object[:beer]
  FactoryBot.create(:rating, beer: beer, score: score, user: object[:user] )
  beer
end

def create_beers_with_many_ratings(object, *scores)
  scores.each do |score|
    create_beer_with_rating(object, score)
  end
end

def create_beers_with_many_ratings_style(object, *scores)
  scores.each do |score|
    create_beer_with_rating_style(object, score)
  end
end