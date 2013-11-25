@SELENIUM_VERSION = "2.37.0"
@RSPEC_VERSION = "2.14.7"

gem 'selenium-webdriver', '=' + @SELENIUM_VERSION
require 'selenium-webdriver'

gem 'rspec-core', '=' + @RSPEC_VERSION
require 'rspec'

puts "[WEBROBOT] (Firefox) v" + @SELENIUM_VERSION
	
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
		if self.example.metadata[:local] == true && ENV['WR_INTERFACE'] != "sauce"
			puts "[WEBROBOT] (Local Firefox) Open:"
			@selenium = Selenium::WebDriver.for :firefox
			@selenium.manage.timeouts.implicit_wait = 35
			@selenium.manage.timeouts.script_timeout = 30
			@selenium.manage.timeouts.page_load = 500
			@selenium.manage.window.resize_to(1280, 1024)
			@selenium.extend WebRobotSingletonMethods
		end
  end
  config.after(:each) do
		if self.example.metadata[:local] == true
			# puts "[WEBROBOT] (Local Firefox) Close:"
			# @selenium.quit if defined?(@selenium)
		end
  end
	
	# ENV['WR_OWNER'].match('SELF')
	# ENV['WR_OWNER'].match('NEOSUITE')
	config.around do |ex|
	puts "[TESTCASE] " + example.description
		ex.run
		if !@selenium.nil? && !example.exception.nil? && ENV['WR_OWNER'] == 'NEOSUITE'
			@selenium.save_screenshot!(ENV['LOGS'] + example.description.gsub(/[^A-Za-z0-9 ]/, '_') + '.png')		
		end
		puts "[WEBROBOT] (Local Firefox) Close:"
		@selenium.quit if defined?(@selenium)
  end
	
  config.after(:suite) do
    ENV.delete('WR_RUNFILTER')
    ENV.delete('WR_FORCEDISPLAY')
    ENV.delete('WR_FFONLY')
    ENV.delete('WR_NOTUNNEL')
    ENV.delete('WR_URL')
    ENV.delete('WR_USERNAME')
    ENV.delete('WR_USERPASS')
    ENV.delete('WR_OWNER') #SELF or NEOSUITE
  end
end