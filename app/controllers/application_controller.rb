class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper
  
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end

  def counts(user)
    @count_pictures = user.pictures.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_favopictures = user.favopictures.count
  end
  def fvcounts(picture)
    @fvcount_users = picture.users.count
    @fvcount_photocmts = picture.photocmts.count
  end
end
