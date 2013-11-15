require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

describe "Install Wizard - PBX Only", :local => true do
	it "should run through the install wizard as a PBX only configuration" do
		#PPMAuthMacro.new(suite).navigate_wizard
		@selenium.navigate.to "http://admin:password@10.10.9.129:81/main/wizard/startup/startup_welcome.html"
		@selenium.wait_for_element_present(:id, "createNew", 15) 
		@selenium.click(:xpath, '//*[@id="createNew"]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="modal-upload-submit"]')
		sleep 10
		@selenium.click(:xpath, '//*[@id="next"]')
		sleep 5
		@selenium.clear(:id, 'voiceLanIpAddr')
		@selenium.type(:id, 'voiceLanIpAddr', '10.10.9.129')
		@selenium.clear(:id, "voiceLanSubnetMask")
		@selenium.type(:id, 'voiceLanSubnetMask', '255.255.248.0')
		@selenium.clear(:id, "defaultGateway")
		@selenium.type(:id, 'defaultGateway', '10.10.8.1')
		@selenium.clear(:id, "primaryDns")
		@selenium.type(:id, 'primaryDns', '10.10.8.2')
		@selenium.clear(:id, "secondaryDns")
		@selenium.type(:id, 'secondaryDns', '10.10.14.200')
		@selenium.click(:id, 'next')
		sleep 3
		@selenium.click(:xpath, "(//input[@id='next'])[2]")
		driver.switch_to.alert.accept rescue Selenium::WebDriver::Error::NoAlertOpenError
		sleep 2
		@selenium.select_by(:id, 'time_zone', :text, "(GMT-05:00) Eastern Time (US & Canada)") 
		@selenium.clear(:id, "operatorExt")
		@selenium.type(:id, 'operatorExt', '1600')
		@selenium.click(:id, 'next')
		sleep 3
		@selenium.check(:id, 'trunk_fxo_checkbox')
		@selenium.check(:id, 'trunk_pri_checkbox')
		@selenium.check(:id, 'trunk_voip_checkbox')
		@selenium.click(:id, 'next')
		@selenium.clear(:id, "trunk_description")
		@selenium.type(:id, "trunk_description", "FXO Trunk")
		@selenium.click(:id, 'next')
		sleep 10
		@selenium.clear(:id, "trunk_description")
		@selenium.type(:id, "trunk_description", "PRI Trunk")
		@selenium.clear(:id, "main_number")
		@selenium.type(:id, "main_number", "613 599-9698") 
		@selenium.select_by(:id, 'priSwitchType', :text, "Nortel DMS-100")
		sleep 5
		@selenium.click(:id, 'next')
		sleep 5
		@selenium.clear(:id, "trunk_description")
		@selenium.type(:id, "trunk_description", "SIP Trunk")
		@selenium.clear(:id, "main_number")
		@selenium.type(:id, "main_number", "888 599-9698") 
		@selenium.clear(:id, "sip_server_address")
		@selenium.type(:id, "sip_server_address", "10.10.9.173")
		@selenium.clear(:id, "sip_proxy_address")
		@selenium.type(:id, "sip_proxy_address", "10.10.9.173")
		@selenium.click(:id, 'next')
		sleep 5
		@selenium.click(:id, 'next')
		sleep 30
		@selenium.click(:id, 'next')
		sleep 5
		@selenium.click(:css, "html")
		sleep 3
		@selenium.switch_frame("user_table_frame")
		sleep 5
		if @selenium.is_element_present(:id, "delete1", 5)
		@selenium.click(:xpath, "//*[@id='delete1']")
		end
		@selenium.click(:xpath, "//*[@id='bottom_area']/td")
		@selenium.clear(:id, "extension2")
		@selenium.type(:id, "extension2", "3011")
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