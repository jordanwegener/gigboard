class BandsController < ApplicationController
  def index
    @bands = Band.all
  end

  def show
  end

  def new
    @band = Band.new
  end
end
