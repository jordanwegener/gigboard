class UsersController < ApplicationController
  def index
    if current_user
      @user = current_user
    else
      redirect_to new_user_session_path, notice: "You are not logged in."
    end

    @user_negotiations_as_band = []
    @user.bands.each do |band|
      band.negotiations.each do |negotiation|
        @user_negotiations_as_band << negotiation
      end
    end

    @user_negotiations_as_gig = []
    @user.gigs.each do |gig|
      gig.negotiations.each do |negotiation|
        @user_negotiations_as_gig << negotiation
      end
    end
  end
end
