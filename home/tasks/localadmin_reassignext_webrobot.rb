require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

def wait_for_element_present( how, what, how_long=5)
	p("-- wait_for_element_present [ #{how.to_s}," + what + "," + how_long.to_s + " ]")
	wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long )
	wait_for_it.until { @selenium.find_element(how, what) }
end

describe "Local Admin - Reassign Extension", :local => true do
	it "should test reassigning an extension" do
		@selenium.navigate.to "http://10.10.9.129/Login/index.php"
		wait_for_element_present(:id, "loginnameid-inputEl", 15)
		@selenium.type(:id, "loginnameid-inputEl", 'admin')
		@selenium.type(:id, "loginpasswordid-inputEl", 'password')
		sleep 1
		@selenium.click(:id, "loginbuttonid-btnIconEl")
		sleep 3
		@selenium.click(:xpath, '//*[@id="reassignExtension_wiz"]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="reAssignUser_grid-body"]/div/table/tbody/tr[2]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="reAssignExtensionWiz_next_btn-btnEl"]')
		@selenium.type(:id, 'reAssignExtWizFirstNameField_txtinput-inputEl', "Reassign")
		@selenium.type(:id, 'reAssignExtWizLastNameField_txtinput-inputEl', "Test")
		@selenium.type(:id, 'reAssignExtWizCellPhoneField_txtinput-inputEl', "(613) 555-0193")
		@selenium.check(:id, "reAssignExtWizPreserveEmail_checkbox-inputEl")
		@selenium.click(:xpath, '//*[@id="reAssignExtensionWiz_next_btn-btnEl"]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="reAssignExtensionWiz_save_btn-btnEl"]')
    end
end
