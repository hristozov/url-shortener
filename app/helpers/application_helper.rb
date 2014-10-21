# Global helpers for the application.
module ApplicationHelper
  def at_home?
    # XXX
    # current_page?(:controller => 'shortened_urls', :action => 'index')
    true
  end

  def at_sign_up?
    false
  end

  def at_sign_in?
    false
  end

  def signed_in?
    current_user != nil
  end
end
