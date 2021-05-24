class GigsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_gig, only: [:show]
  before_action :authorize_gig, only: [:edit, :update, :destroy, :deactivate]

  def index
    @gigs = Gig.where(active: true)
  end

  def show
  end

  def new
    @gig = Gig.new
    flash[:alert] = "Gig successfully listed!"
    redirect_to gigs_path
  end

  def create
    @gig = current_user.gigs.new(gig_params)
    if @gig.save
      redirect_to @gig
    else
      render :new
    end
  end

  def destroy
    @gig.destroy
    flash[:alert] = "Gig successfully removed!"
    redirect_to gigs_path
  end

  private

  def gig_params
    params.require(:gig).permit(:title, :location, :start_time, :end_time, :ask_price, :description, :date)
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
