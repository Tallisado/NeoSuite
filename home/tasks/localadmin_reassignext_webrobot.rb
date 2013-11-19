require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

describe "Local Admin - Reassign Extension", :local => true do
	it "should test reassigning an extension" do
		@selenium.navigate.to "http://10.10.9.129/Login/index.php"
		@selenium.wait_for_element_present(:id, "loginnameid-inputEl", 15)
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
