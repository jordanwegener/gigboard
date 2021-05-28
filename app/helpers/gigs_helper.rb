module GigsHelper
  def check_user_negotiations_as_band(gig)
    return nil unless current_user.bands
    current_user.bands.each do |band|
      return nil unless band.negotiations
      band.negotiations.each do |negotiation|
        if negotiation.gig_id == gig.id && negotiation.active_band == true
          return negotiation.id
          break
        end
      end
    end
    return nil
  end

  def check_user_negotiations_as_gig(gig)
    return nil unless current_user.gigs
    current_user.gigs.each do |gig|
      return nil unless gig.negotiations
      gig.negotiations.each do |negotiation|
        if negotiation.gig_id == gig.id && negotiation.active == true
          return negotiation.id
          break
        end
      end
    end
    return nil
  end
end
