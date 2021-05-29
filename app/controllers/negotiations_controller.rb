class NegotiationsController < ApplicationController
  before_action :set_negotiation, except: [:new, :create, :index]
  before_action :authorize_negotiation_gig, only: [:deactivate_gig, :accept, :reject, :edit, :pay]
  before_action :authorize_negotiation_band, only: [:deactivate_band]
  before_action :authorize_negotiation, only: [:show]

  def new
    @gig = Gig.find(params[:id])
    @negotiation = Negotiation.new
    @bands = current_user.bands
  end

  def create
    @gig = Gig.find(params[:id])
    @negotiation = @gig.negotiations.new(negotiation_params)
    if @negotiation.save
      flash.notice = "Booking request made successfully!"
      redirect_to negotiation_path(@negotiation)
    else
      flash.alert = "Something went wrong. Please try again and if the problem persists contact an administrator."
      render :new
    end
  end

  def deactivate(type)
    @negotiation.update(active: false) if type == "gig"
    @negotiation.update(active_band: false) if type == "band"
    @negotiation.destroy unless @negotiation.active || @negotiation.active_band
    flash.notice = "Booking request has been removed."
    redirect_to gigs_path
  end

  def deactivate_gig
    deactivate("gig")
  end

  def deactivate_band
    deactivate("band")
  end

  def accept
    if @negotiation.update(status: "accepted")
      redirect_to negotiation_path
      flash.notice = "Booking request accepted!"
    else
      redirect_to negotiation_path
      flash.alert = "Something went wrong. Please try again and if the problem persists contact an administrator."
    end
  end

  def reject
    if @negotiation.update(status: "rejected")
      redirect_to negotiation_path
      flash.notice = "Booking request rejected."
    else
      redirect_to negotiation_path
      flash.alert = "Something went wrong. Please try again and if the problem persists contact an administrator."
    end
  end

  def edit
  end

  def success
    @negotiation.update(status: "paid")
  end

  def failed
  end

  def index
    @negotiations = []
    @gig = Gig.find(params[:gig_id])
    @gig.negotiations.each do |negotiation|
      @negotiations << negotiation if negotiation.active && negotiation.active_band
    end
  end

  def show
    @gig = @negotiation.gig
    @band = @negotiation.band
    if @gig.user == current_user
      @deposit = (@negotiation.gig.ask_price) * 20
      stripe_session = Stripe::Checkout::Session.create(
        payment_method_types: ["card"],
        client_reference_id: current_user.id,
        customer_email: current_user.email,
        line_items: [{
          amount: @deposit.to_i,
          name: "Deposit: booking for #{@negotiation.gig.title}",
          description: @negotiation.gig.description,
          currency: "aud",
          quantity: 1,
        }],
        payment_intent_data: {
          metadata: {
            booking_id: @negotiation.id,
            user_id: current_user.id,
          },
        },
        success_url: "#{root_url}negotiation/success/#{@negotiation.id}",
        cancel_url: "#{root_url}negotiation/failed/#{@negotiation.id}",
      )
      @session_id = stripe_session.id
    end
  end

  private

  def authorize_negotiation
    return if @negotiation.gig.user == current_user || @negotiation.band.user == current_user
    flash[:alert] = "You lack the permissions to do this. If you think this is an error, please contact an administrator."
    redirect_to gigs_path
  end

  def authorize_negotiation_gig
    return if @negotiation.gig.user == current_user
    flash[:alert] = "You lack the permissions to do this. If you think this is an error, please contact an administrator."
    redirect_to gigs_path
  end

  def authorize_negotiation_band
    return if @negotiation.band.user == current_user
    flash[:alert] = "You lack the permissions to do this. If you think this is an error, please contact an administrator."
    redirect_to gigs_path
  end

  def set_negotiation
    @negotiation = Negotiation.find(params[:id])
  end

  def negotiation_params
    params.require(:negotiation).permit(:band_id, :message)
  end
end
