class PhotocmtsController < ApplicationController
  before_action :require_user_logged_in

  def update
  end

  def create
    @photocmt = current_user.photocmts.build(photocmt_params)
    @photocmt.picture_id = params[:picture_id]
    if @photocmt.save
      flash[:success] = 'コメントを投稿しました。'
      redirect_back(fallback_location: root_path)
    else
      @photocmts = current_user.photocmts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'コメントの投稿に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @photocmt.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
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
