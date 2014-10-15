module ApplicationHelper
  def is_at_home?
    # XXX
    #current_page?(:controller => 'shortened_urls', :action => 'index')
    true
  end

  def is_at_sign_up?
    false
  end

  def is_at_sign_in?
    false
  end

  def is_signed_in?
    !!current_user
  end
end
