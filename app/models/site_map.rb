class SiteMap < ActiveRecord::Base
  validates :url, format: { with: URI::regexp(%w(http https)),
    message: "only allows letters" }

  def valid_url?(url)
      String(url) =~ URI::regexp(%w(http https))
    end
end
