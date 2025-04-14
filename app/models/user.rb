class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username,  uniqueness: true,
                        length: { in: 3...30 }
  validates :password, length: { minimum: 4 }, format: { with: /(?=.*[A-Z])(?=.*[0-9]).*/, message: "requires at least one uppcase letter and number" }

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def to_s
    username.to_s
  end

  def favorite_beer
    return nil if ratings.empty? # palautetaan nil jos reittauksia ei ole

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?

    ave = {}
    ratings.pluck(:beer_id).uniq.map do |r|
      sty = ratings.where(beer_id: r).first.beer.style

      ratings.where(beer_id: r).map do |s|
        sco = s.score
        if ave[sty].nil?
          ave[sty] = [sco]
        else
          ave[sty] << sco
        end
      end
    end
    ave.max_by{ |_k, v| v.sum / v.count }[0]
  end

  def favorite_brewery
    return nil if ratings.empty?

    ave = {}
    ratings.pluck(:beer_id).uniq.map do |r|
      bre = ratings.where(beer_id: r).first.beer.brewery.name

      ratings.where(beer_id: r).map do |s|
        sco = s.score
        if ave[bre].nil?
          ave[bre] = [sco]
        else
          ave[bre] << sco
        end
      end
    end
    ave.max_by{ |_k, v| v.sum / v.count }[0]
  end
end
