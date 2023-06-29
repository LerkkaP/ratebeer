require 'rails_helper'

include Helpers

describe "Beer" do
    let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }

    before :each do
        sign_in(username: "Pekka", password: "Foobar1")
    end

    it "is added if name is not blank" do
        visit new_beer_path
        fill_in('beer_name', with: 'Karhu')
        select('Weizen', from: 'beer[style]')
        select('Koff', from: 'beer[brewery_id]')

        expect{
            click_button('Create Beer')
        }.to change{Beer.count}.by(1)
    end
    it "is not added if name is blank" do
        visit new_beer_path
        fill_in('beer_name', with: '')
        select('Weizen', from: 'beer[style]')
        select('Koff', from: 'beer[brewery_id]')

        expect{
            click_button('Create Beer')
        }.to change{Beer.count}.by(0)
        expect(page).to have_content "Name can't be blank"
    end
end