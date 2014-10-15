require "digest/sha2"

class ShorteningService
  def self.shorten(url)
    Time.now().to_i.to_s(36).slice(-4..-1) + Digest::SHA256.new().hexdigest(url).hex().to_s(36).slice(0, 4)
  end
end