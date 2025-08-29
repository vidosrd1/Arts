class PagesController < ApplicationController
  def home
    Pagy::VARS[:max_items] = 50 # Set the value you want!
@pagy, @records = pagy(Car.all, max_items: 50)
#@pagy, @records = pagy(Car.all)
  end

  def nav
  end
end
