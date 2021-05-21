class GigsController < ApplicationController
  def index
    @gigs = Gig.all
  end

  def show
  end

  def new
    @gig = Gig.new
    flash[:alert] = "Gig successfully listed!"
    redirect_to gigs_path
  end

  def create
    @listing = current_user.listings.new(listing_params)
    if @listing.save
      redirect_to @listing
    else
      render :new
    end
  end

  def destroy
    @gig.destroy
    flash[:alert] = "Gig successfully deleted!"
    redirect_to gigs_path
  end
end
