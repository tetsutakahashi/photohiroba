class PicturesController < ApplicationController
  before_action :require_user_logged_in, only: [:mew, :edit, :create, :destroy]
  
  def new
    @picture = current_user.pictures.build  # form_for 用
  end

  def edit
    @picture = Picture.find(params[:id])
  end
  
  def create
    @picture = current_user.pictures.build(picture_params)
    if @picture.save
      flash[:success] = '写真を投稿しました。'
      redirect_to user_path(@picture.user)
    else
      flash.now[:danger] = '写真の投稿に失敗しました。'
      render 'new'
    end
  end
  
  def update
    @picture = Picture.find(params[:id])
    if @picture.update(picture_params)
      flash[:success] = '写真、及び情報を変更しました。'
      redirect_to user_path(@picture.user)
    else
      flash.now[:danger] = '写真、及び情報の変更に失敗しました。'
      render 'edit'
    end
  end
  
  
  def photoview
    @photo = Picture.find(params[:id])
    @user = User.find(@photo.user)
    @pictures = @user.pictures.order('created_at DESC').page(params[:page]).per(12)
    @photocmts = Photocmt.where(picture_id: @photo.id).order('created_at DESC').page(params[:page]).per(12)
    fvcounts(@photo)
    if logged_in?
      @photocmt = current_user.photocmts.build
    end
  end
  
  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    flash[:success] = '写真を削除しました。'
    redirect_to user_path(@picture.user)
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
