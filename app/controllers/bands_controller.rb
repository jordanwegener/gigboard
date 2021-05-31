class BandsController < ApplicationController
  before_action :set_band, only: [:show, :edit, :update, :destroy, :deactivate]
  before_action :authorize_band, only: [:update, :edit, :destroy]

  def index
    @bands = Band.all
  end

  def show
  end

  def create
    params[:band][:demo] = base64encode(params[:band][:demo]) if params[:band][:demo]
    @band = Band.new(band_params)
    @band.user = current_user
    if @band.save
      flash.notice = "Band successfully created!"
      redirect_to @band
    else
      flash.alert = "Something went wrong. Please try again and if the problem persists contact an administrator."
      render "new"
    end
  end

  def update
    params[:band][:demo] = base64encode(params[:band][:demo]) if params[:band][:demo]
    if @band.update(band_params)
      flash.notice = "Band successfully updated!"
      redirect_to @band
    else
      flash.alert = "Something went wrong. Please try again and if the problem persists contact an administrator."
      render "edit"
    end
  end

  def edit
  end

  def new
    @band = Band.new
  end

  def destroy
    if @band.destroy
      flash.notice = "Band successfully removed!"
      redirect_to gigs_path
    else
      flash.alert = "Something went wrong. Please try again and if the problem persists contact an administrator."
    end
  end

  private

  def band_params
    params.require(:band).permit(:name, :location, :style, :description, :demo)
  end

  def authorize_band
    @band = current_user.bands.find_by_id(params[:id])
    return if @band
    flash[:alert] = "You lack the permissions to do this. If you think this is an error, please contact an administrator."
    redirect_to gigs_path
  end

  def set_band
    @band = Band.find(params[:id])
  end
end
