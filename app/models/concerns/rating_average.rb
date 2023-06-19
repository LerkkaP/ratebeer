module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    scores = ratings.map(&:score)
    (scores.sum.to_f / ratings.count).truncate(1)
  end
end
