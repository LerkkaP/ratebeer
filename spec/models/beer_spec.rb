require 'rails_helper'

RSpec.describe Beer, type: :model do

  describe "Creation" do
    let(:brewery) { Brewery.create(name: "Test Brewery", year: 2021) }

      it "is valid with a name, style, and brewery" do
        beer = Beer.create(name: "Test Beer", style: "Test Style", brewery_id: brewery.id)
        expect(beer).to be_valid
        expect(Beer.count).to eq(1)
    end

      it "is not valid without a name" do
        beer = Beer.create(style: "Test Style", brewery_id: brewery.id)
        expect(beer).not_to be_valid
        expect(Beer.count).to eq(0)
    end

      it "is not valid without a style" do
        beer = Beer.create(name: "Test Beer", brewery_id: brewery.id)
        expect(beer).not_to be_valid
        expect(Beer.count).to eq(0)
    end
  end
end
