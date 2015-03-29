class SiteMapBuilderWorker
  include Sidekiq::Worker

  def perform(url, id)
    puts "Building map for #{url}"
    map = SiteMap.find(id)
    map.xml = SiteMapBuilder.build(url)
    map.rendered = true
    map.failed = false
    map.save
    puts "Map Built!"
  rescue => e
    map.failed = true
    map.save
    puts e.message
    fail e
  end
end