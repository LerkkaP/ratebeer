class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  PASSWORD_FORMAT = /\A
  (?=.*\d)          
  (?=.*[A-Z])        
  /x

  validates :password, length: { minimum: 4}, format: { with: PASSWORD_FORMAT }

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }

  has_many :ratings
  has_many :beers, through: :ratings
  has_many :memberships
  has_many :beer_clubs, through: :memberships

  def already_member_of?(beer_club)
    beer_clubs.include?(beer_club)
  end
end
