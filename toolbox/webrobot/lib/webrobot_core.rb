$LOAD_PATH.unshift File.dirname(__FILE__)

require 'webrobot_helpermethods'
require 'webrobot_singletonmethods'



if ENV['WR_INTERFACE'].match('sauce')
	gem 'sauce', '=3.2.0'
	require 'sauce'
	require 'sauce/rspec'
	puts "[WEBROBOT] Sauce v" + Sauce.version
	require 'webrobot_saucefig'
	
elsif ENV['WR_INTERFACE'].match('local')
	@SELENIUM_VERSION = "2.37.0"
	gem 'selenium-webdriver', '=' + @SELENIUM_VERSION
	require 'selenium-webdriver'
	puts "[WEBROBOT] (Firefox) v" + @SELENIUM_VERSION
	require 'webrobot_rspecfig'
	a = $LOADED_FEATURES.
		 select { |feature| feature.include? 'gems' }.
		 map { |feature| File.dirname(feature) }.
		 map { |feature| feature.split('/')[-3] }.
		 uniq.sort.to_s
	puts "LOADED FEATURES:"
	puts a
end

#export SAUCE_USERNAME=esthernaholowaa
#export SAUCE_ACCESS_KEY=4c2695d1-33c5-4d38-acb4-69dbb79f0b8c

#export SAUCE_USERNAME=talliskane
#export SAUCE_ACCESS_KEY=6c3ed64b-e065-4df4-b921-75336e2cb9cf