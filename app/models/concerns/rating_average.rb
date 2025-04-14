module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    ratings.average(:score).to_f.round(2)
  end

  def average_style
    styles = Set
    ratings.each do |r|
      styles << r.beer.style.unique
    end
  end
end
