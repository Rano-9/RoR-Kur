class Beer < ApplicationRecord
  include RatingAverage

  validates :name, length: { minimum: 1 }
  validates :style, length: { minimum: 1 }

  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :user

  def average
    if ratings.count == 0
      return 0
    end

    ratings.map(&:score).sum / ratings.count.to_f
  end

  def to_s
    "#{name} #{brewery.name}"
  end
end
