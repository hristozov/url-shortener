# Represents a shortened URL.
class ShortenedUrl < ActiveRecord::Base
  belongs_to :user

  def shorten!
    ShorteningService.shorten(self)
    save!
  end
end
