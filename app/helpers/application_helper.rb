# Global helpers for the application.
module ApplicationHelper
  def at_home?
    current_page? '/'
  end

  def at_sign_up?
    current_page? '/users/sign_up'
  end

  def at_sign_in?
    current_page? '/users/sign_in'
  end

  def at_my_links?
    current_page? '/users/me'
  end

  def signed_in?
    current_user != nil
  end
end
