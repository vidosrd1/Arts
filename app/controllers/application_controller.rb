class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  include Pagy::Backend

  def page
    p = params[:page].to_i # converts strings to 0 (or the number they start with)
    p.positive? ? p : 1 # when no valid page number is given, set page to 1
  end
end
