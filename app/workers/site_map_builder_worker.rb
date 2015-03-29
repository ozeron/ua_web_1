class SiteMapBuilderWorker
  include Sidekiq::Worker

  def perform(url, id)
    puts "Building map for #{url}"
    map = SiteMap.find(id)
    map.xml = SiteMapBuilder.build(url)
    map.rendered = true
    map.save
    puts "Map Built!"
  rescue
    map.failed = true
    map.save
  end
end