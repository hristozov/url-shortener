class ShortenedUrlsController < ApplicationController
  before_action :set_shortened_url, only: [:show]

  def show
  end

  def new
    @shortened_url = ShortenedUrl.new();
  end

  def create
    @shortened_url = ShortenedUrl.new(shortened_url_params)
    @shortened_url.user_id = current_user.id

    respond_to do |format|
      if @shortened_url.save
        format.html { redirect_to action: :show, id: @shortened_url.id, notice: 'Yeah!' }
      else
        format.html { render :new }
      end
    end

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_shortened_url
    @shortened_url = ShortenedUrl.find(params[:id])
  end

  def shortened_url_params
    params.require(:shortened_url).permit(:original)
  end
end
