require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

describe "NEO Accessibility", :local => true do
	it "should serve the login page to access assets" do
		@selenium.navigate.to "http://10.10.9.129/Login/index.php"
		sleep 1
		expect { @selenium.wait_for_element_present(:id, "loginnameid-inputEl", 15) }.to_not raise_error	
		@selenium.title.should eql("ADTRAN Neo")
	end
	
	it "should allow us to login", :local => true do
		@selenium.navigate.to "http://10.10.9.129/Login/index.php"
		expect {  	
			@selenium.wait_for_element_present(:id, "loginnameid-inputEl", 15)
			@selenium.type(:id, "loginnameid-inputEl", 'admin')
			@selenium.type(:id, "loginpasswordid-inputEl", 'password')
			sleep 1
			@selenium.click(:id, "loginbuttonid-btnIconEl")
			
			@selenium.relaxed_wait_for_element_present(:id, "createUser_wiz", 5)
		}.to_not raise_error	
		@selenium.current_url.should eq("http://10.10.9.129/LocalAdmin/index.php")
		#@selenium.current_url.should eq("http://10.10.9.129/LocalAdmin/index.phpasd")
	end
end