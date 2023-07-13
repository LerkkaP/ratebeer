class Brewery < ApplicationRecord
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validates :year, numericality: {
    only_integer: true,
    less_than_or_equal_to: ->(_brewery) { Date.current.year },
    greater_than_or_equal_to: 1040
  }

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil, false] }

  def self.top_by_average_rating(n)
    all.sort_by { |brewery| -brewery.average_rating.to_f }.take(n)
  end

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2022
    puts "changed year to #{year}"
  end
end
