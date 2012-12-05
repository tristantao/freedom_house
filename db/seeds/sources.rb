#!/bin/env ruby
# encoding: utf-8

sources = [{:name => "Daily Trust", :home_page => "www.dailytrust.com.ng", :url => "http://www.dailytrust.com.ng/index.php/rss/xml/RSS2.0/full", :quality_rating => "10"},
#{:name => "CLEEN Foundation", :home_page => "http://www.kabissa.org/directory/CLEEN", :url => "http://feeds.feedburner.com/CleenFoundation?format=xml", :quality_rating => 10},
           #{:name => "The Guardian", :home_page => "http://www.ngrguardiannews.com/", :feed_type => 'Twitter', :url => "NGRGUARDIANNEWS", :quality_rating => 10},
#{:name => "Nigerian Tribune", :home_page => "http://tribune.com.ng/", :url => "http://tribune.com.ng/news2013/index.php/en/community-news?format=feed", :quality_rating => 10},
           #{:name => "Vanguard News", :home_page => "http://www.vanguardngr.com/", :feed_type => 'Twitter', :url => "vanguardngrnews", :quality_rating => 10},
#{:name => "The Punch", :home_page => "http://www.punchng.com/", :url => "http://www.punchng.com/feed/", :quality_rating => 10},
#{:name => "Leadership Newspaper", :home_page => "http://www.leadership.ng/nga/", :url => "http://feeds.feedburner.com/LeadershipNGA?format=xml", :quality_rating => 10},
           #{:name => "Nigerian Compass", :home_page => "http://www.compassnewspaper.org/", :url => "http://www.compassnewspaper.org/index.php/news/nigeria-today?format=feed", :quality_rating => 10}
]

sources.each do |source|
  Source.create!(source)
end
