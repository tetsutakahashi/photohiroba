class UsersController < ApplicationController
  
  def index
    @users = User.all.order('created_at DESC').page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @pictures = @user.pictures.order('created_at DESC').page(params[:page]).per(12)
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = '登録を削除しました。'
    redirect_to root_path
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.order('created_at DESC').page(params[:page]).per(10)
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.order('created_at DESC').page(params[:page]).per(10)
    counts(@user)
  end
  
  def myfavorites
    @user = User.find(params[:id])
    @favopictures = @user.favopictures.order('created_at DESC').page(params[:page]).per(12)
    counts(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
