class ToppagesController < ApplicationController
  def index
      @pictures = Picture.all.order('created_at DESC').page(params[:page]).per(12)
  end
end
