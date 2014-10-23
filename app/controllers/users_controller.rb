# Functionality for manipulating users.
class UsersController < ApplicationController
  before_action :set_urls, only: [:show_profile]
  before_action :set_user, only: [:show_profile]

  def show_profile
    respond_to do |format|
      format.html
    end
  end

  private

  def set_urls
    @shortened_urls = ShortenedUrl.where(user_id: current_user.id)
  end

  def set_user
    @user = current_user
  end
end
