require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

describe "NeoSuite DryRun", :local => true do
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
	
	it "should save screenshot on test failure" do
		@selenium.navigate.to "http://www.google.ca"   
		expect { @selenium.title.should eql("NotGoogle") }.to raise_error
	end

		# need reliable way to do this
	# it "should use url from profile" do
		# p "-- using env variable from task definition"
		# @selenium.navigate.to ENV['BASEURL']
		# expect { @selenium.current_url.should eql(ENV['URL']) }.to_not raise_error
	# end
	
	# need reliable way to do this
	# it "should use url from rake" do
		# p "-- overriding env url variable locally"
		# ENV['BASEURL'] = "http://www.reddit.com/"
		# @selenium.navigate.to ENV['BASEURL']
		# expect { @selenium.title.should eql("reddit: the front page of the internet") }.to_not raise_error
	# end
	

	#it "::custom#login http://10.10.9.129/Login/index.php 3011 1234 settingsButton" do
	it "selenium#login" do
		@selenium.login(3011, 1234, 'settingsButton')
		expect { @selenium.title.should eql("ADTRAN Neo") }.to_not raise_error
	end
	
end

# local browser
# -- [LOCAL] Starting firefox :
# -- [LOCAL] quit firefox
  # should open browser locally

# Finished in 7.48 seconds
# 1 example, 0 failures