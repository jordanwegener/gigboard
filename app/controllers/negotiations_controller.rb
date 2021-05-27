class NegotiationsController < ApplicationController
  def new
    @gig = Gig.find(params[:id])
    @negotiation = Negotiation.new
    @bands = current_user.bands
  end

  def create
    @gig = Gig.find(params[:id])
    @negotiation = @gig.negotiations.new(negotiation_params)
    if @negotiation.save
      redirect_to negotiation_path(@negotiation)
    else
      render :new
    end
  end

  def show
    @negotiation = Negotiation.find(params[:id])
    @gig = @negotiation.gig
    @band = @negotiation.band
  end

  def negotiation_params
    params.require(:negotiation).permit(:band_id, :message)
  end
end
