class Brewery < ApplicationRecord
  include RatingAverage

  validates :name, length: { minimum: 1 }
  validates :year, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1040,
    less_than_or_equal_to: Date.today.year
  }

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil,false] }


  #def self.top(n)
  #  list = self.all.sort_by{ |b| -b.ratings.average(:score)}
  #end

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = Date.today.year
    puts "changed year to #{year}"
  end
end
