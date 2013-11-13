require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

# def wait_for_element_present( how, what, how_long=5)
	# p("-- wait_for_element_present [ #{how.to_s}," + what + "," + how_long.to_s + " ]")
	# wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long )
	# wait_for_it.until { @selenium.find_element(how, what) }
# end

# def type(method, element, text)
	# p("-- typing text ['#{text}'] into element ['#{element}'] by ['#{method}']")
	# @selenium.find_element(method, element).send_keys text
	# sleep 0.2
# end

describe "NEO Accessibility", :local => true do
	it "should serve the login page to access assets" do
		@selenium.navigate.to "http://10.10.9.129/Login/index.php"
		@selenium.wait_for_element_present(:id, "loginnameid-inputEl", 15)
		@selenium.title.should eql("ADTRAN Neo")
	end
	
	# it "should allow us to login", :local => true do
		# @selenium.navigate.to "http://10.10.9.129/Login/index.php"
		# @selenium.wait_for_element_present(:id, "loginnameid-inputEl", 15)
		# @selenium.type(:id, "loginnameid-inputEl", 'admin')
		# @selenium.type(:id, "loginpasswordid-inputEl", 'password')
		# sleep 1
		# @selenium.click(:id, "loginbuttonid-btnIconEl")
			
		# @selenium.relaxed_wait_for_element_present(:id, "createUser_wiz", 5)
		# @selenium.current_url.should_not eq("http://10.10.9.129/Login/index.php")
	# end
end

# local browser
# -- [LOCAL] Starting firefox :
# -- [LOCAL] quit firefox
  # should open browser locally

# Finished in 7.48 seconds
# 1 example, 0 failures