class ShorteningNotifier < ActionMailer::Base
  default from: 'proba@proba.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.shortening_notifier.shortened.subject
  #
  def shortened(user, url)
    @url = url

    mail to: user.email
  end
end
