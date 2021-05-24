class BandsController < ApplicationController
  def index
    @bands = Band.all
  end

  def show
  end

  def create
    @band = current_user.bands.new(band_params)
    if @band.save
      redirect_to @band
    else
      render :new
    end
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
    params.require(:band).permit(:name, :location, :style, :description)
  end
end
