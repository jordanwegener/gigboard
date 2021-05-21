class GigsController < ApplicationController
  def index
    @gigs = Gig.all
  end

  def show
  end

  def new
    @gig = Gig.new
  end

  def destroy
    @gig.destroy
    flash[:alert] = "Successfully Destroyed"
    redirect_to gigs_path
  end
end
