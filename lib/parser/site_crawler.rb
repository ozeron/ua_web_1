require 'open-uri'
require_relative 'url_builder'

class SiteCrawler
  DEPTH = 3

  attr_reader :base_url, :order_queue

  def self.crawl(url)
    new(url).crawl
  end

  def crawl()
    order_queue << [build_valid(base_url),DEPTH]
    while !order_queue.empty? do
      parse(*order_queue.pop)
    end
    puts @parsed_links.inspect
    @parsed_links
  end

  private

  def initialize(url)
    @base_url = URI(url)
    @parsed_links = []
    @order_queue = []
  end

  def parse(url, depth)
    return '' if depth == 0 || visited?(url)
    doc = Nokogiri::HTML(html(url))
    @parsed_links << url.to_s
    puts "Visited '#{url.to_s}' current depth #{depth}, parsed links #{@parsed_links.size}"
    links = doc.css('a')
                .map{|i| build_valid(i['href'])}
                .select(&same_host(url))
                .select(&not_indexed)
    links.each{|x| @order_queue.push([x,depth-1])}
  end

  def html(url)
    open(build_valid(url)) rescue ''
  end

  def build_valid(url)
    UrlBuilder.url(url, base_url)
  end

  def same_host(url)
    url = URI(url)
    lambda do |x|
      host = URI(x).host rescue nil
      return true if host.nil?
      host.include?(url.host.to_s)
    end
  end

  def not_indexed(urls=[])
    lambda do |x|
      !urls.include?(x) && !visited?(x) && !in_queue?(x)
    end
  end

  def not_empty
    lambda { |x| !x.empty? }
  end

  def in_queue?(url)
    @order_queue.include?(url)
  end

  def visited?(url)
    @parsed_links.include?(url)
  end
end