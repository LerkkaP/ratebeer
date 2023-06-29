require 'rails_helper'

include Helpers

describe "User" do
  let!(:user) { FactoryBot.create(:user, username: "Pekka", password: "Foobar1") }
  let!(:brewery) { FactoryBot.create(:brewery, name: "Koff") }
  let!(:beer1) { FactoryBot.create(:beer, name: "iso 3", brewery: brewery) }

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

      expect(current_path).to eq(user_path(user.id))
      expect(page).to have_content "iso 3 10"
    end
  end
end