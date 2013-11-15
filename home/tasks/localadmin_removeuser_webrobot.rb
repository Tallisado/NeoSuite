require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

def wait_for_element_present( how, what, how_long=5)
	p("-- wait_for_element_present [ #{how.to_s}," + what + "," + how_long.to_s + " ]")
	wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long )
	wait_for_it.until { @selenium.find_element(how, what) }
end

describe "Local Admin - Remove User", :local => true do
	it "should remove the specified user" do
		@selenium.navigate.to "http://10.10.9.129/Login/index.php"
		wait_for_element_present(:id, "loginnameid-inputEl", 15)
		@selenium.type(:id, "loginnameid-inputEl", 'admin')
		@selenium.type(:id, "loginpasswordid-inputEl", 'password')
		sleep 1
		@selenium.click(:id, "loginbuttonid-btnIconEl")
		sleep 3
		@suite.click(:xpath, '//*[@id="removeUser_wiz"]')
		@suite.click_text_from_combobox(:id, 'removeUserWiz_comboBox-inputEl', "Automated User")	
		sleep 5
		@suite.click(:xpath, '//*[@id="removeUserWizard_next_btn"]')
		@suite.click(:xpath, '//*[@id="removeUserWizard_save_btn"]')
		sleep 5

		@suite.click(:xpath, '//*[@id="removeUser_wiz"]')
		@suite.click_text_from_combobox(:id, 'removeUserWiz_comboBox-inputEl', "Reassign Test")	
		sleep 5
		@suite.click(:xpath, '//*[@id="removeUserWizard_next_btn"]')
		@suite.click(:xpath, '//*[@id="removeUserWizard_save_btn"]')
		sleep 5
    end
end
