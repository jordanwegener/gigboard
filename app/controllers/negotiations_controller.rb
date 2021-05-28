class NegotiationsController < ApplicationController
  before_action :set_negotiation, except: [:new, :create]

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

  def deactivate_gig
    @negotiation.update(active: false)
    flash.notice = "Booking request has been removed."
    redirect_to gigs_path
  end

  def deactivate_band
    @negotiation.update(active_band: false)
    flash.notice = "Booking request has been removed."
    redirect_to gigs_path
  end

  def accept
    if @negotiation.update(status: "accepted")
      redirect_to negotiation_path
      flash.notice = "Booking request accepted!"
    else
      redirect_to negotiation_path
      flash.alert = "Something went wrong. Please try again and if the problem persists contact an administrator."
    end
    puts "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    puts @negotiation.inspect
  end

  def reject
    if @negotiation.update(status: "rejected", active: false)
      redirect_to negotiation_path
      flash.notice = "Booking request rejected."
    else
      redirect_to negotiation_path
      flash.alert = "Something went wrong. Please try again and if the problem persists contact an administrator."
    end
    puts "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    puts @negotiation.inspect
  end

  def edit
  end

  def pay
  end

  def show
    @gig = @negotiation.gig
    @band = @negotiation.band
  end

  private

  def set_negotiation
    @negotiation = Negotiation.find(params[:id])
  end

  def negotiation_params
    params.require(:negotiation).permit(:band_id, :message)
  end
end
