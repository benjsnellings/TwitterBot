#!/usr/bin/env ruby

require "rubygems"
require "twitter"
# require 'mechanize'
require 'open-uri'
require 'nokogiri'
require 'logger'

bbc_sites = 
[
	'http://www.bbc.com/news/technology',
	'http://www.bbc.com/news/science_and_environment',
	'http://www.bbc.com/news',
	'http://www.bbc.com/news/world/us_and_canada'
]



client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "3Gj9Ot3BH2YNXTdgPLJnXRyCD"
  config.consumer_secret     = "Sv0cHyN2sqi9tRsIH91WpKJau1bYSNI9N0lO46AfkQKuCqTFHK"
  config.access_token        = "4870693817-WJxNENmp2cNmiXcMOBJCAjfvKpS3i3iAd00BZZj"
  config.access_token_secret = "487BIcqvCyYSKTq3Hw4dKkRido1hE1966vspAvPE3l5hZ"
end



# def tweet_bbc(client)
# 	random = rand(5)
# 	mechanize = Mechanize.new
# 	url = 'http://www.bbc.com/news/science_and_environment'
# 	page = mechanize.get(url)
# 	filtered = page.links.reject{|item| item.dom_class != "title-link"}
# 	link = filtered[random]
# 	puts link
# 	client.update(link.to_s.strip + "\n" + link.resolved_uri.to_s + "\n#J150UMD") 
# end

def nokogiri_bbc(client, bbc_sites, logger)
	random1 = rand(10)
	random2 = rand(4)
	doc = Nokogiri::HTML(open(bbc_sites[random2]))
	link =  "www.bbc.com" + doc.css('a.title-link')[random1]["href"]
	title = doc.css('a.title-link')[random1].css('span').text
	# puts title + " Randoms = [" + random1.to_s + "," + random2.to_s + "]"
	logger.info(title + " Randoms = [" + random1.to_s + "," + random2.to_s + "]")
	client.update(title + "\n" + link + "\n#J150UMD")
end

logger = Logger.new('/home/pi/Documents/workspace/TwitterBot/log.txt')
# tweet_bbc client
nokogiri_bbc(client, bbc_sites, logger)
logger.close