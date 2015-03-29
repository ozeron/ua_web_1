class UrlSanitizer
  include Singleton
  include ActionView::Helpers::SanitizeHelper

  class << self
    include ActionView::Helpers::SanitizeHelper::ClassMethods
  end
  def self.sanitize(url)
    new.sanitize(url.to_s.gsub(' ','%20'))
  end
end