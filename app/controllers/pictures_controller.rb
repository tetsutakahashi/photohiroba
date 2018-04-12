class PicturesController < ApplicationController
  before_action :require_user_logged_in
  
  def new
    @picture = current_user.pictures.build  # form_for 用
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    if @picture.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @pictures = current_user.pictures.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end
  
  def photoview
    @user = User.find(params[:id])
    @photo = Picture.find(params[:photoid])
    @pictures = @user.pictures.order('created_at DESC').page(params[:page]).per(12)
  end
  

  def destroy
    @picture.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def picture_params
    params.require(:picture).permit(:title, :description, :tag, :cmmaker, :cmmodelcode, :lzmaker, :lzmount, :lzmodelcode, :image, :image_cache, :remove_image)
  end

  def correct_user
    @picture = current_user.pictures.find_by(id: params[:id])
    unless @picture
      redirect_to root_url
    end
  end
end