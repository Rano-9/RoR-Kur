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
      
      redirect_to beer_club_path(:beer_club_id), notice: "#{current_user} welcome to the club"
    else
      @beer_club = BeerClub.where.not id: current_user.membership_ids
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    membership = Membership.where(id: params[:id]).first
    beer_club = membership.beer_club
    membership.delete
    redirect_to current_user, notice: "Membership in #{beer_club} ended"
  end
end
