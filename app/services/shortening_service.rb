require 'digest/sha2'

# Provides shortening capabilities for urls.
class ShorteningService
  def self.shorten(shortened_url)
    url = shortened_url.original
    timestamp_part = Time.now.to_i.to_s(36).slice(-4..-1)
    url_part = Digest::SHA256.new.hexdigest(url).hex.to_s(36).slice(0, 4)
    id = timestamp_part + url_part
    shortened_url.shortened = BASE_PATH + '/' + id
  end
end
