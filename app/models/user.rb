class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  PASSWORD_FORMAT = /\A
  (?=.*\d)
  (?=.*[A-Z])
  /x

  validates :password, length: { minimum: 4 }, format: { with: PASSWORD_FORMAT }

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def already_member_of?(beer_club)
    beer_clubs.include?(beer_club)
  end

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?

    ratings.group_by { |rating| rating.beer.style }.max_by { |_style, ratings| average_rating_best(ratings) }.first
  end

  def average_rating_best(ratings)
    ratings.sum(&:score).to_f / ratings.size
  end
end
