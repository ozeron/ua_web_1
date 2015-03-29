require_relative 'url_sanitizer'

class UrlBuilder
  attr_reader :base_url

  def self.url(url, base_url=nil)
    UrlBuilder.new(UrlSanitizer.sanitize(url),base_url)
        .url().to_s.chomp('/')
  end

  def url
    return @url if valid_url?(@url)
    return base_url if empty_url?(@url)
    @url = validate_scheme(@url)
    @url = validate_host(@url)
    @url
  end

  private

  SHEMAS = ['http','https']

  def initialize(url, base_url)
    @url = URI(url.to_s) unless black_listed?(url) rescue URI('')
    @base_url = URI(base_url.to_s)
  end

  def empty_url?(url)
    url.to_s.empty?
  end

  def validate_scheme(url)
    return url if valid_scheme?(url)
    URI(base_url.scheme + '://'+ url.to_s)
  rescue URI::InvalidURIError
    URI(base_url+ url.to_s)
  end

  def validate_host(url)
    url.host = base_url.host unless valid_host?(url)
    url
  end

  def valid_scheme?(url)
    SHEMAS.include?((url).scheme)
  end

  def valid_host?(url)
    !url.host.nil?
  end

  def valid_url?(url)
    String(url) =~ URI::regexp(%w(http https))
  end

  def black_listed?(url)
    @@black_list_url ||= %w(http://# https://# #)
    return true if contain_black_listed?(url)
    @@black_list_url.include?(url)
  end

  def contain_black_listed?(url)
    url =~ /(mailto:|skype:|javascript:)/
  end
end

