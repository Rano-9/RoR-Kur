class MembershipsController < ApplicationController
  def new
    @membership = Membership.new
    club = current_user.memberships.map(&:beer_club_id)
    @beer_club = BeerClub.where.not id: club
  end

  def create
    @membership = Membership.new params.require(:membership).permit(:beer_club_id)

    @membership.user = current_user

    if @membership.save
      redirect_to current_user
    else
      @beer_club = BeerClub.where.not id: current_user.membership_ids
      render :new, status: :unprocessable_entity
    end
  end
end
