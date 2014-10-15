class ShortenedUrlsController < ApplicationController
  before_action :set_shortened_url_by_id, only: [:show]
  before_action :set_shortened_url_by_url, only: [:redirect]

  def show
  end

  def redirect
    if @shortened_url
      redirect_to @shortened_url.original
    else
      not_found
    end
  end

  def new
    @shortened_url = ShortenedUrl.new();
  end

  def create
    @shortened_url = ShortenedUrl.new(shortened_url_params)
    @shortened_url.user_id = current_user.id
    @shortened_url.shorten!

    respond_to do |format|
      if @shortened_url.save
        format.js
        format.html { redirect_to action: :show, id: @shortened_url.id, notice: 'Yeah!' }
      else
        format.html { render :new }
      end
    end
  end

  private
  def set_shortened_url_by_id
    @shortened_url = ShortenedUrl.find(params[:id])
  end

  def set_shortened_url_by_url
    @shortened_url = ShortenedUrl.where(shortened: BASE_PATH + "/" + params[:id]).first
  end

  def shortened_url_params
    params.require(:shortened_url).permit(:original)
  end
end
