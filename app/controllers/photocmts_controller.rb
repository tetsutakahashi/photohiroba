class PhotocmtsController < ApplicationController
  before_action :require_user_logged_in
  
  def edit  
    @editcmt = Photocmt.find(params[:id])
    @user = User.find(@editcmt.user)
    @photo = Picture.find(@editcmt.picture)
    @pictures = @user.pictures.order('created_at DESC').page(params[:page]).per(12)
    @photocmts = Photocmt.where(picture_id: @photo.id).order('created_at DESC').page(params[:page]).per(12)
    fvcounts(@photo)
    if logged_in?
      @photocmt = current_user.photocmts.build
    end
  end  

  def update
    @photocmt = Photocmt.find(params[:photocmt_id])
    @picture = Picture.find(@photocmt.picture)
    if @photocmt.update(photocmt_params)
      flash[:success] = '写真、及び情報を変更しました。'
      redirect_to photoview_picture_path(@picture)
    else
      flash.now[:danger] = '写真、及び情報の変更に失敗しました。'
      render 'edit'
    end
  end

  def create
    @photocmt = current_user.photocmts.build(photocmt_params)
    @photocmt.picture_id = params[:picture_id]
    if @photocmt.save
      flash[:success] = 'コメントを投稿しました。'
      redirect_back(fallback_location: root_path)
    else
      @photocmts = current_user.photocmts.order('created_at DESC').page(params[:page])
      flash[:danger] = 'コメントの投稿に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @photocmt = Photocmt.find(params[:id])
    @picture = Picture.find(@photocmt.picture)
    @photocmt.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_to photoview_picture_path(@picture)
  end

  private

  def photocmt_params
    params.require(:photocmt).permit(:comment)
  end
  
  def correct_user
    @photocmt = current_user.photocmts.find_by(id: params[:id])
    unless @photocmt
      redirect_to photoview_picture_url
    end
  end
end
