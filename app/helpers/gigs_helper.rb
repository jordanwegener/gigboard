module GigsHelper
  def check_user_negotiations_as_gig(check_gig)
    negotiations = []
    return unless current_user.gigs
    current_user.gigs.each do |gig|
      return unless gig.negotiations
      gig.negotiations.each do |negotiation|
        negotiations << negotiation if negotiation.gig_id == check_gig.id && negotiation.active_band && negotiation.active
      end
    end
  end

  def check_user_negotiations_as_band(gig)
    return unless current_user.bands
    current_user.bands.each do |gig|
      return unless gig.negotiations
      gig.negotiations.each do |negotiation|
        if negotiation.gig_id == gig.id && negotiation.active_band && negotiation.active
          return negotiation.id
          break
        end
      end
    end
    return
  end
end
