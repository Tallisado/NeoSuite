require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

describe "NeoSuite", :local => true do
	it "should have access to custom WebRobot API" do
		@selenium.navigate.to "http://10.10.9.129/Login/index.php"
		@selenium.wait_for_element_present(:id, "loginnameid-inputEl", 15)
		@selenium.type(:id, "loginnameid-inputEl", 'admin')
		@selenium.type(:id, "loginpasswordid-inputEl", 'password')
		File.open('/mnt/wt/neosuite/rogertest.txt', 'w') {|f| f.write(@selenium.page_source) }
	end
end