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