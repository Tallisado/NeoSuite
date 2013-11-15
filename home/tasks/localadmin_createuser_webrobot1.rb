require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

def wait_for_element_present( how, what, how_long=5)
	p("-- wait_for_element_present [ #{how.to_s}," + what + "," + how_long.to_s + " ]")
	wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long )
	wait_for_it.until { @selenium.find_element(how, what) }
end

describe "Local Admin - Create User", :local => true do
	it "should create some users on the system" do
		@selenium.navigate.to "http://10.10.9.129/Login/index.php"
		wait_for_element_present(:id, "loginnameid-inputEl", 15)
		@selenium.type(:id, "loginnameid-inputEl", 'admin')
		@selenium.type(:id, "loginpasswordid-inputEl", 'password')
		sleep 1
		@selenium.click(:id, "loginbuttonid-btnIconEl")
		sleep 3
		@selenium.click(:xpath, '//*[@id="createUser_wiz"]')
		sleep 2
		@selenium.type(:id, 'createUsersWizardFirstNameField_txtinput-inputEl', 'Automated')
		@selenium.type(:id, 'createUsersWizardLastNameField_txtinput-inputEl', 'User')
		@selenium.type(:id, 'createUsersWizardDescriptionField_txtinput-inputEl', 'Creating user for automated test')
		@selenium.clear(:id, 'createUsersWizardExtensionNumberField_txtinput-inputEl')
		@selenium.type(:id, 'createUsersWizardExtensionNumberField_txtinput-inputEl', '100')
		@selenium.type(:id, 'createUsersWizardCellPhoneField_txtinput-inputEl', '6135550134')
		#@selenium.type(:id, 'createUsersWizardPrimEmailField_txtinput-inputEl', 'automated.user@example.com')
		#@selenium.type(:id, 'createUsersWizardSecEmailField_txtinput-inputEl', 'automated.user@hotmail.com')
		@selenium.click(:xpath, '//*[@id="createUserWiz_next_btn-btnWrap"]')
		sleep 3
		@selenium.save_screenshot('/mnt/wt/neosuite/radio.png')
		
		
		
		
		@selenium.click(:xpath, '//*[@id="default_radio-inputEl"]')
		@selenium.click(:xpath, '//*[@id="createUserWiz_next_btn-btnWrap"]')
		#@selenium.click_text_from_combobox(:id, 'createUserWizardAddPhoneModel_comboBox-inputEl', "ADTRAN VVX 300")
		#@selenium.type(:id, 'createUserWizardAddPhoneMACAddress_textBox-inputEl', "111111111111")
		#@selenium.click(:id, 'createUserWizardUnassignedPhone_gridconfig-record-11:11:11:11:11:11')
		#@selenium.click(:id, 'createUserWizardAssignPhoneRight_button-btnEl')
		#@selenium.click(:xpath, '//*[@id="createUserWiz_next_btn-btnWrap"]')
		sleep 2
		@selenium.click(:xpath, '//*[@id="createUserWiz_skip_btn-btnIconEl"]')
		#@selenium.type(:id, 'createUsersWizardELR_txtinput-inputEl', "Area 51")
		#@selenium.click(:xpath, '//*[@id="createUserWiz_next_btn-btnWrap"]')
		sleep 2
		@selenium.click(:xpath, '//*[@id="createUserWiz_save_btn-btnIconEl"]')
    end
end
