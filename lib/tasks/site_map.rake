require 'parser/site_map_builder'

task :site_map, [:url] do |t, args|
  puts SiteMapBuilder.build(args[:url]).inspect
end