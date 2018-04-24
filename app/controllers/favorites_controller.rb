class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    picture = Picture.find(params[:picture_id])
    current_user.favort(picture)
    flash[:success] = 'pictureをお気に入りに追加しました。'
    path = Rails.application.routes.recognize_path(request.referer)
    redirect_to photoview_picture_path(picture)
  end

  def destroy
    picture = Picture.find(params[:picture_id])
    current_user.unfavort(picture)
    flash[:success] = 'pictureをお気に入りから解除しました。'
    path = Rails.application.routes.recognize_path(request.referer)
    redirect_to photoview_picture_path(picture)
  end
  
end
