require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/helper")

def wait_for_element_present( how, what, how_long=5)
	p("-- wait_for_element_present [ #{how.to_s}," + what + "," + how_long.to_s + " ]")
	wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long )
	wait_for_it.until { @selenium.find_element(how, what) }
end

describe "cloud browser", :sauce => true do
	it "should open browser remotely" do
		@selenium.navigate.to "http://10.10.9.129/Login/index.php"
		wait_for_element_present(:id, "loginnameid-inputEl", 15)
		@suite.type(:id, "loginnameid-inputEl", 'admin')
		@suite.type(:id, "loginpasswordid-inputEl", 'password')
		sleep 1
		@suite.click(:id, "loginbuttonid-btnIconEl")
		wait_for_element_present(:id, "createUser_wiz", 20)
		@selenium.title.should eql("ADTRAN Neo")
	end
end

# local browser
# -- [LOCAL] Starting firefox :
# -- [LOCAL] quit firefox
  # should open browser locally

# Finished in 7.48 seconds
# 1 example, 0 failures