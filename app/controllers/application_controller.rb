require "base64"

class ApplicationController < ActionController::Base
  def base64encode(file)
    str = File.read(file.tempfile)
    header = "data:audio/mp3;base64,"
    base64str = Base64.encode64(str)
    header + base64str
  end
end
