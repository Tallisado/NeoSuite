require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

describe "NeoSuite DryRun", :local => true do
	it "should save screenshot" do
		@selenium.navigate.to "http://www.google.ca"   
		@selenium.save_screenshot!("#{ENV['LOGS']}should_save_screenshot.png")
		File.exist?(@selenium.last_saved_screenshot).should be_true
	end
end