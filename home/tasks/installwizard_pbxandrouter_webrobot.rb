require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

describe "Install Wizard - PBX and Router", :local => true do
	it "should run through the install wizard as a PBX and Router configuration" do
		#PPMAuthMacro.new(suite).navigate_wizard
		@selenium.navigate.to "http://admin:password@10.10.9.129:81/main/wizard/startup/startup_welcome.html"
		@selenium.wait_for_element_present(:id, "createNew", 15)
		@selenium.click(:xpath, '//*[@id="createNew"]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="modal-upload-submit"]')
		sleep 10
		# @selenium.execute_script("scroll(296, 0)")
		# @selenium.execute_script("scroll(293, 0)")
		@selenium.execute_script("scroll(305, 0)")
		@selenium.click(:xpath, '//*[@id="optionA"]')
		driver.switch_to.alert.accept rescue Selenium::WebDriver::Error::NoAlertOpenError
		sleep 5
		@selenium.click(:xpath, '//*[@id="next"]')
		driver.switch_to.alert.accept rescue Selenium::WebDriver::Error::NoAlertOpenError
		sleep 5
		@selenium.check(:xpath, '//*[@id="use_dhcp"]')
		# @selenium.click(:xpath, '//*[@id="remoteAdminEnabled"]')
		@selenium.click(:id, 'next')
		driver.switch_to.alert.accept rescue Selenium::WebDriver::Error::NoAlertOpenError
		sleep 5
		@selenium.click(:xpath, "(//input[@id='next'])[2]")
		sleep 3
		driver.switch_to.alert.accept rescue Selenium::WebDriver::Error::NoAlertOpenError
		sleep 5
		@selenium.select_by(:id, 'time_zone', :text, "(GMT-05:00) Eastern Time (US & Canada)") 
		@selenium.clear(:id, "operatorExt")
		@selenium.type(:id, 'operatorExt', '1600')
		@selenium.click(:id, 'next')
		sleep 3
		@selenium.check(:id, 'trunk_fxo_checkbox')
		@selenium.check(:id, 'trunk_pri_checkbox')
		@selenium.check(:id, 'trunk_voip_checkbox')
		@selenium.click(:id, 'next')
		sleep 3
		@selenium.clear(:id, "trunk_description")
		@selenium.type(:id, "trunk_description", "FXO Trunk")
		@selenium.click(:id, 'next')
		sleep 3
		@selenium.clear(:id, "trunk_description")
		@selenium.type(:id, "trunk_description", "PRI Trunk")
		@selenium.clear(:id, "main_number")
		@selenium.type(:id, "main_number", "613 599-9698") 
		@selenium.select_by(:id, 'priSwitchType', :text, "Nortel DMS-100")
		sleep 3
		@selenium.click(:id, 'next')
		sleep 2
		@selenium.clear(:id, "trunk_description")
		@selenium.type(:id, "trunk_description", "ITSP Trunk")
		@selenium.clear(:id, "main_number")
		@selenium.type(:id, "main_number", "888 599-9698") 
		@selenium.clear(:id, "sip_server_address")
		@selenium.type(:id, "sip_server_address", "10.10.9.173")
		@selenium.clear(:id, "sip_proxy_address")
		@selenium.type(:id, "sip_proxy_address", "10.10.9.173")
		@selenium.click(:id, 'next')
		sleep 1
		@selenium.click(:id, 'next')
		sleep 1
		@selenium.click(:id, 'next')
		sleep 1
		driver.switch_to.alert.accept rescue Selenium::WebDriver::Error::NoAlertOpenError
		@selenium.click(:css, "html")
		@selenium.switch_frame("user_table_frame")
		sleep 5
		if @selenium.is_element_present(:id, "delete1", 5)
		@selenium.click(:xpath, "//*[@id='delete1']")
		end
		@selenium.click(:xpath, "//*[@id='bottom_area']/td")
		@selenium.clear(:id, "extension2")
		@selenium.type(:id, "extension2", "1001")
		@selenium.select_by(:id, 'phoneModel2', :text, 'ADTRAN/Polycom IP 321') 
		@selenium.clear(:id, "mac_address2")
		@selenium.type(:id, "mac_address2", "0010395b9d33")
		@selenium.clear(:id, "first_name2")
		@selenium.type(:id, "first_name2", "Wizard")
		@selenium.clear(:id, "last_name2")
		@selenium.type(:id, "last_name2", "User")
		@selenium.switch_frame_default()
		@selenium.click(:id, 'next')
		sleep 30
		# @selenium.click(:xpath, "//*[@id='apply']")
	end
end