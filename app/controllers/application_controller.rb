require "base64"

class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    flash.alert = "You do not have permission to do this. If you think this is an error, please contact an administrator."
    redirect_to gigs_path
  end

  def base64encode(file)
    str = File.read(file.tempfile)
    header = "data:audio/mp3;base64,"
    base64str = Base64.encode64(str)
    header + base64str
  end
end
