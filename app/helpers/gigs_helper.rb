module GigsHelper
  def check_user_negotiations_as_gig(check_gig)
    negotiations = []
    return unless current_user.gigs
    current_user.gigs.each do |gig|
      return unless gig.negotiations
      gig.negotiations.each do |negotiation|
        negotiations << negotiation if negotiation.gig_id == check_gig.id && negotiation.active
      end
    end
    return if negotiations.empty?
  end

  def check_user_negotiations_as_band(check_gig)
    negotiations = []
    return unless current_user.bands
    current_user.bands.each do |band|
      return unless band.negotiations
      band.negotiations.each do |negotiation|
        negotiations << negotiation if negotiation.gig_id == check_gig.id && negotiation.active_band
      end
    end
    return if negotiations.empty?
  end

  def check_bands_negotiations_exist(check_gig)
    negotiations = []
    return unless current_user.bands
    current_user.bands.each do |band|
      return unless band.negotiations
      band.negotiations.each do |negotiation|
        negotiations << negotiation if negotiation.gig_id == check_gig.id && negotiation.active_band
      end
    end
    if negotiations.empty?
      return false
    else
      return true
    end
  end

  def check_gigs_negotiations_exist(check_gig)
    negotiations = []
    return unless current_user.gigs
    current_user.gigs.each do |gig|
      return unless gig.negotiations
      gig.negotiations.each do |negotiation|
        negotiations << negotiation if negotiation.gig_id == check_gig.id && negotiation.active
      end
    end
    if negotiations.empty?
      return false
    else
      return true
    end
  end
end
