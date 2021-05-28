class GigsController < ApplicationController
  # before_action :authenticate_user, only: [:new, :edit]
  before_action :set_gig, only: [:show]
  before_action :authorize_gig, only: [:edit, :update, :destroy, :deactivate]

  def index
    @gigs = Gig.search(params[:search])
  end

  def create
    @gig = Gig.new(gig_params)
    @gig.user = current_user
    if @gig.save
      redirect_to gig_path(@gig)
    else
      render "new"
    end
  end

  def show
    @gig = Gig.find_by_id(params[:id])
  end

  def new
    @gig = Gig.new
  end

  def destroy
    @gig.destroy
    flash[:alert] = "Gig successfully removed!"
    redirect_to gigs_path
  end

  def book
  end

  def edit
    @gig = Gig.find_by_id(params[:id])
  end

  def update
    @gig = Gig.find_by_id(params[:id])
    if @gig.update(gig_params)
      redirect_to @gig
    else
      render "new"
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
