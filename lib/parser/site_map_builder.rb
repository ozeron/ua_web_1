require_relative 'site_crawler'

class SiteMapBuilder
  attr_reader :links

  def self.build(url)
    new(url).build()
  end

  def build
    builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
      xml.urlset('xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9') {
        links.each do |link|
          xml.loc link
        end
      }
    end
    builder.to_xml
  end

  private

  def initialize(url)
    @links = SiteCrawler.crawl(url)
  end
end