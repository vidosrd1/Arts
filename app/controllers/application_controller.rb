class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  include Pagy::Method

  stale_when_importmap_changes
end
