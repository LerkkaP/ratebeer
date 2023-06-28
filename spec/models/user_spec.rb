require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new(username: "Pekka")
    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create(username: "Pekka")
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user) do
      User.create(
        username: "Pekka",
        password: "Secret1",
        password_confirmation: "Secret1"
      )
    end

    let(:test_brewery) { Brewery.new(name: "test", year: 2000) }
    let(:test_beer) { Beer.create(name: "testbeer", style: "teststyle", brewery: test_brewery) }

    it "has a password longer than 3 characters and includes uppercase letters" do
      expect(user.password.length).to be >= 4
      expect(user.password).to match(/[A-Z]/)
    end

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      rating = Rating.new(score: 10, beer: test_beer)
      rating2 = Rating.new(score: 20, beer: test_beer)

      user.ratings << rating
      user.ratings << rating2

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "with an invalid password" do
    it "is not saved when the password is too short" do
      user = User.create(username: "Pekka", password: "Sec", password_confirmation: "Sec")
      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end

    it "is not saved when the password is lowercase only" do
      user = User.create(username: "Pekka", password: "password", password_confirmation: "password")
      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end
  end
end