class UpdatesController < ApplicationController
  def create
    ios     = params[:ios]
    android = params[:android]

    if ios || android
      prev = Updatee.where(
        email: params[:email]
      )
      if prev.length != 0
        prev[0].ios = ios
        prev[0].android = android
        prev[0].save
      else
        Updatee.create!(
          ios: ios,
          android: android,
          email: params[:email]
        )
        puts params[:email]
      end
    end
    render :nothing => true
  end
end
