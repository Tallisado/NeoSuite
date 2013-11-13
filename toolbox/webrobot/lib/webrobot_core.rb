$LOAD_PATH.unshift File.dirname(__FILE__)

require 'webrobot_helpermethods'
require 'webrobot_singletonmethods'
require 'sauce'
require 'sauce/rspec'

RSpec.configure do |config|
	config.include WebRobotHelperMethods
	if ! ENV['WR_INTERFACE'].nil?
		if ENV['WR_INTERFACE'].match('sauce')
			config.filter_run_including :sauce => true
		elsif ENV['WR_INTERFACE'].match('local')
			config.filter_run_including :local => true
		end
	end
  config.before(:each) do
	  #puts -- Interface is: ENV['WR_INTERFACE']
		if self.example.metadata[:local] == true && ENV['WR_INTERFACE'] != "sauce" ||
				self.example.metadata[:sauce] == true && ENV['WR_INTERFACE'] != "sauce"
			puts "[WEBROBOT] (Local Firefox) Open:"
			@selenium = Selenium::WebDriver.for :firefox
			@selenium.manage.timeouts.implicit_wait = 35
			@selenium.manage.timeouts.script_timeout = 30
			@selenium.manage.timeouts.page_load = 500
			@selenium.extend WebRobotSingletonMethods
		end
  end
  config.after(:each) do
		if self.example.metadata[:local] == true
			puts "[WEBROBOT] (Local Firefox) Close:"
			@selenium.quit if defined?(@selenium)
		end
  end
  config.after(:suite) do
    ENV.delete('WR_RUNFILTER')
    ENV.delete('WR_FORCEDISPLAY')
    ENV.delete('WR_FFONLY')
    ENV.delete('WR_NOTUNNEL')
    ENV.delete('WR_URL')
    ENV.delete('WR_USERNAME')
    ENV.delete('WR_USERPASS')
  end
end

#export SAUCE_USERNAME=esthernaholowaa
#export SAUCE_ACCESS_KEY=4c2695d1-33c5-4d38-acb4-69dbb79f0b8c

#export SAUCE_USERNAME=talliskane
#export SAUCE_ACCESS_KEY=6c3ed64b-e065-4df4-b921-75336e2cb9cf

Sauce.config do |c|
  if !ENV['WR_NOTUNNEL'].nil? || ENV['WR_INTERFACE'] == 'local'
		puts "[WEBROBOT] (Sauce) Not using the tunnel for SauceConnect"
		c[:start_tunnel] = false
	end
	if ! ENV['WR_FFONLY'].nil?
		puts "[WEBROBOT] (Sauce) Targeted browsers - Firefox 19"
		c[:browsers] = [
			["Linux", "Firefox", "19"]
		]
	else
		puts "[WEBROBOT] (Sauce) Targeted browsers - Full Supported browser list"
		c[:browsers] = [
			["Windows 7", "Internet Explorer", "9"],
			["Linux", "Firefox", "19"],
			["OSX 10.6", "Chrome", nil]
		]
	end

end