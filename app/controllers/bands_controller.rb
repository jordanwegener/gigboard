class BandsController < ApplicationController
  def index
    @bands = Band.all
  end

  def show
    @band = Band.find(params[:id])
  end

  def create
    params[:band][:demo] = base64encode(params[:band][:demo]) if params[:band][:demo]
    @band = Band.new(band_params)
    @band.user = current_user
    if @band.save
      redirect_to @band
    else
      render "new"
    end
  end

  def update
  end

  def edit
    @band = Band.find(params[:id])
  end

  def new
    @band = Band.new
  end

  def destroy
    @band.destroy
    flash[:alert] = "Band successfully removed!"
    redirect_to bands_path
  end

  def band_params
    params.require(:band).permit(:name, :location, :style, :description, :demo)
  end
end
