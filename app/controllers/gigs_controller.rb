class GigsController < ApplicationController
  before_action :set_gig, only: [:show, :edit, :update]
  before_action :authorize_gig, only: [:edit, :update, :destroy, :deactivate]

  def index
    @gigs = Gig.search(params[:search])
  end

  def create
    @gig = Gig.new(gig_params)
    @gig.user = current_user
    if @gig.save
      flash.notice = "Gig added successfully!"
      redirect_to gig_path(@gig)
    else
      flash.alert = "Something went wrong. Please try again and if the problem persists contact an administrator."
      render "new"
    end
  end

  def show
    @active_negotiation = (Negotiation.where(gig_id: params[:id], active: true, active_band: true))
  end

  def new
    @gig = Gig.new
  end

  def destroy
    @gig.destroy
    flash.notice = "Gig successfully removed!"
    redirect_to gigs_path
  end

  def book
  end

  def edit
  end

  def update
    if @gig.update(gig_params)
      redirect_to @gig
    else
      render "edit"
    end
  end

  private

  def gig_params
    params.require(:gig).permit(:title, :location, :start_time, :end_time, :ask_price, :description, :date, :search)
  end

  def authorize_gig
    @gig = current_user.gigs.find_by_id(params[:id])
    return if @gig
    flash[:alert] = "You lack the permissions to do this. If you think this is an error, please contact an administrator."
    redirect_to gigs_path
  end

  def set_gig
    @gig = Gig.find(params[:id])
  end
end
