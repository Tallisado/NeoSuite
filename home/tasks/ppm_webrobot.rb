require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

def wait_for_element_present( how, what, how_long=5)
	p("-- wait_for_element_present [ #{how.to_s}," + what + "," + how_long.to_s + " ]")
	wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long )
	wait_for_it.until { @selenium.find_element(how, what) }
end

def type(method, element, text)
        p("-- typing text ['#{text}'] into element ['#{element}'] by ['#{method}']")
        @selenium.find_element(method, element).send_keys text
        sleep 0.2
   end

def click(method, element)
      # -- 'element' could be a javascript, then we need to call 'run_script' instead of 'click'
      if /jQuery/.match(element)
         p("-- running script: " + element)
         @selenium.run_script(element)
      else
		p("-- clicking on element: " + element.to_s + " by " + method.to_s)
		@selenium.find_element(method, element).click
      end
   end

describe "PPM Tasks", :local => true do
	it "should test the PPM page" do
		@selenium.navigate.to "http://10.10.9.129/Login/index.php"
		wait_for_element_present(:id, "loginnameid-inputEl", 15)
		type(:id, "loginnameid-inputEl", '3011')
		type(:id, "loginpasswordid-inputEl", '1234')
		sleep 1
		click(:id, "loginbuttonid-btnIconEl")
		wait_for_element_present(:id, "settingsButton-btnEl", 20)
		@selenium.title.should eql("ADTRAN Neo")
		sleep 5
		click(:id, "logout-btnEl")
		sleep 2

		wait_for_element_present(:id, "loginnameid-inputEl", 15)
		type(:id, "loginnameid-inputEl", "3011")
		type(:id, "loginpasswordid-inputEl", "password")
		click(:id, "loginbuttonid-btnIconEl")		
		@selenium.find_elements(:id, "settingsButton-btnEl".size() < 1)

		wait_for_element_present(:id, "loginnameid-inputEl", 15)
		type(:id, "loginnameid-inputEl", "3011")
		type(:id, "loginpasswordid-inputEl", "4567")
		click(:id, "loginbuttonid-btnIconEl")
		@selenium.find_elements(:id, "settingsButton-btnEl".size() < 1)
	end
end

# local browser
# -- [LOCAL] Starting firefox :
# -- [LOCAL] quit firefox
  # should open browser locally

# Finished in 7.48 seconds
# 1 example, 0 failures