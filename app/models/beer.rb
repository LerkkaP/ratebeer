class Beer < ApplicationRecord
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  def average_rating
      scores = ratings.map { |name| name.score}
      (scores.sum.to_f / ratings.count).truncate(1)
    end

  def to_s
    "#{self.name}, #{brewery.name}"
  end
end
