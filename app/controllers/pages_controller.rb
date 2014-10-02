class PagesController < ApplicationController
  before_action :authenticate_user!, only: [
    :inside
  ]

  def home
    render layout: false
  end
  
  def inside
  end 
    
end
