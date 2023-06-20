module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    if ratings.empty?
      0  # tai muu haluamasi oletusarvo
    else
      scores = ratings.map(&:score)
      (scores.sum.to_f / ratings.count).truncate(1)
    end
  end
end
