require 'rails_helper'

include Helpers

describe "User" do
  let!(:user) { FactoryBot.create(:user, username: "Pekka", password: "Foobar1") }
  let!(:brewery) { FactoryBot.create(:brewery, name: "Koff") }
  let!(:beer1) { FactoryBot.create(:beer, name: "iso 3", brewery: brewery) }
  let!(:beer2) { FactoryBot.create(:beer, name: "Sandels", style: "Weizen", brewery: brewery) }

  describe "who has signed up" do
    before :each do
      sign_in(username: "Pekka", password: "Foobar1")
    end
    it "can signin with right credentials" do
    #sign_in(username: "Pekka", password: "Foobar1")


      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end
    it "is redirected back to signin form if wrong credentials given" do
        sign_in(username: "Pekka", password: "wrong")
  
        expect(current_path).to eq(signin_path)
        expect(page).to have_content 'Username and/or password mismatch'
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

    it "has own ratings shown" do
      rating = FactoryBot.create(:rating, score: 10, beer: beer1, user: user)
      
      visit user_path(user.id)

      #puts page.html
      #save_and_open_page

      expect(current_path).to eq(user_path(user.id))
      expect(page).to have_content "iso 3 10"
    end
    
    it "has favorite style and brewery shown" do
      rating1 = FactoryBot.create(:rating, score: 10, beer: beer1, user: user)
      rating2 = FactoryBot.create(:rating, score: 25, beer: beer2, user: user)

      visit user_path(user)

      expect(page).to have_content "iso 3 10"
      expect(page).to have_content "Sandels 25"
      expect(page).to have_content "Weizen"
      expect(page).to have_content "Koff"
    end

    it "can delete their own rating and it is removed from database" do
      rating = FactoryBot.create(:rating, score: 10, beer: beer1, user: user)
      visit user_path(user)

      expect(page).to have_content("iso 3 10")

      within "li" do
        click_button "Delete"
      end

      expect(page).not_to have_content("iso 3 10")
      expect(Rating.count).to eq(0)

      #puts page.html
      #save_and_open_page
    end
  end
end