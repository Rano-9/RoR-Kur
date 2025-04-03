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
end
