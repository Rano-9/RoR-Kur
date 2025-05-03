require 'rails_helper'

include Helpers

describe "User page" do
  let!(:user) {FactoryBot.create :user}
  

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Pekka", password: "wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with: 'Brian')
    fill_in('user_password', with: 'Secret55')
    fill_in('user_password_confirmation', with: 'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  describe "Users page" do
    it "Has no favorites on fresh account" do
      visit users_path
      click_link "Show this user"
      
      expect(page).to have_content "does not have favorite brewery"
      expect(page).to have_content "does not have favorite style"
    end

    it "Has favorites after rating one beer" do
      FactoryBot.create :rating, user:user
      visit users_path
      click_link "Show this user"

      expect(page).to have_content "Favorite style is: Lager"
      expect(page).to have_content "Favorite brewery is: anonymous"
    end

    it "Has different favorites when rating one beer higher" do
      FactoryBot.create :rating, user:user
      brewery = FactoryBot.create :brewery, name: "KOFF"
      style = FactoryBot.create :style, name: "IPA"
      beer = FactoryBot.create :beer, style:style, brewery:brewery
      FactoryBot.create :rating, user:user, score: 20, beer:beer
      
      visit users_path
      click_link "Show this user"
    
      expect(page).to have_content "Favorite style is: IPA"
      expect(page).to have_content "Favorite brewery is: KOFF"
    end
  end

end