desc "This task is called by the Heroku scheduler add-on"
task :scrape_all => :environment do
  puts "Scraping all sources..."
  sources = Source.all
    sources.each do |source|
      if source.scrapable?
        puts "scrapping source " + source.name
        source.queued = true
        source.save
        source.scrape
      end
    end
  puts "done scraping sources."
end
