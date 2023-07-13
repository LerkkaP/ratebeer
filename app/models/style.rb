class Style < ApplicationRecord
  has_many :beers
  has_many :ratings, through: :beers

  validates :name, presence: true
  validates :description, presence: true

  def self.top_by_average_rating(n)
    all.sort_by { |style| -style.average_rating.to_f }.take(n)
  end

  def average_rating
    ratings.average(:score)
  end
end
