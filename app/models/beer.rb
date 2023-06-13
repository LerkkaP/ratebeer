class Beer < ApplicationRecord
  belongs_to :brewery
  has_many :ratings

  def average_rating
      scores = ratings.map { |name| name.score}
      (scores.sum / ratings.count).to_f
    end
end
