# Handles URL shortening requests.
class ShortenedUrlsController < ApplicationController
  before_action :set_shortened_url_by_id, only: [:show]
  before_action :set_shortened_url_by_url, only: [:redirect]

  def show
    respond_to do |format|
      format.html
      format.pdf { render pdf: 'contents' }
    end
  end

  def redirect
    if @shortened_url
      redirect_to @shortened_url.original
    else
      not_found
    end
  end

  def new
    @shortened_url = ShortenedUrl.new
  end

  def create
    @shortened_url = ShortenedUrl.new(shortened_url_params)
    user = current_user
    @shortened_url.user_id = user.id
    @shortened_url.shorten!
    new_id = @shortened_url.id

    ShorteningNotifier.shortened(user, @shortened_url).deliver

    respond_to do |format|
      if @shortened_url.save
        format.js
        format.html { redirect_to action: :show, id: new_id, notice: 'Yeah!' }
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
    shortened_url_raw = BASE_PATH + '/' + params[:id]
    @shortened_url = ShortenedUrl.where(shortened: shortened_url_raw).first
  end

  def shortened_url_params
    params.require(:shortened_url).permit(:original)
  end
end
