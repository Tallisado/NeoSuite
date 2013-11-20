require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

describe "PPM Tasks", :local => true do
	it "should test the PPM page" do
		@selenium.navigate.to "http://10.10.9.129/Login/index.php"
		@selenium.wait_for_element_present(:id, "loginnameid-inputEl", 15)
		@selenium.type(:id, "loginnameid-inputEl", '3011')
		@selenium.type(:id, "loginpasswordid-inputEl", '1234')
		sleep 1
		@selenium.click(:id, "loginbuttonid-btnIconEl")
		@selenium.wait_for_element_present(:id, "settingsButton-btnEl", 20)
		@selenium.title.should eql("ADTRAN Neo")
		sleep 5
		@selenium.click(:id, "logout-btnEl")
		sleep 2

		@selenium.wait_for_element_present(:id, "loginnameid-inputEl", 15)
		@selenium.type(:id, "loginnameid-inputEl", "3011")
		@selenium.type(:id, "loginpasswordid-inputEl", "password")
		@selenium.click(:id, "loginbuttonid-btnIconEl")		
		@selenium.find_elements(:id, "settingsButton-btnEl".size() < 1)

		@selenium.wait_for_element_present(:id, "loginnameid-inputEl", 15)
		@selenium.type(:id, "loginnameid-inputEl", "3011")
		@selenium.type(:id, "loginpasswordid-inputEl", "4567")
		@selenium.click(:id, "loginbuttonid-btnIconEl")
		@selenium.find_elements(:id, "settingsButton-btnEl".size() < 1)
	end
end