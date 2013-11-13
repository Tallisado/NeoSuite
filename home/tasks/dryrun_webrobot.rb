require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

describe "NeoSuite", :local => true do
	it "should instantiate the local WebRobot Firefox object" do
		expect { @selenium.navigate.to "http://www.google.ca" }.to_not raise_error
	end

	it "should have access to custom WebRobot API" do
		expect { @selenium.navigate.to "http://www.google.ca" }.to_not raise_error
		expect { @selenium.clear_cookies }.to_not raise_error
		expect { @selenium.clear_cookies_disabled }.to raise_error
	end
	
	it "should navigate the a url" do
		@selenium.navigate.to "http://www.google.ca"   
		@selenium.title.should eql("Google")
	end
end

# local browser
# -- [LOCAL] Starting firefox :
# -- [LOCAL] quit firefox
  # should open browser locally

# Finished in 7.48 seconds
# 1 example, 0 failures