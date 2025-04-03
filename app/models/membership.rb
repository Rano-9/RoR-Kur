class Membership < ApplicationRecord
  validates :user_id, :beer_club_id, { presence: true }

  belongs_to :beer_club
  belongs_to :user

  def to_s
    beer_club.name.to_s
  end
end
