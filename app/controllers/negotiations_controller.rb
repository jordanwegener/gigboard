class NegotiationsController < ApplicationController
  def new
    @negotiation = Negotiation.new
  end

  def create
    @negotiation = current_gig.negotiations.new #(negotiation_params)
    if @negotiation.save
      redirect_to @negotiation
    else
      render :new
    end
  end

  #   def negotiation_params
  #     params.require(:negotiation).permit(:title, :location, :start_time, :end_time, :ask_price, :description, :date, :search)
  #   end
end
