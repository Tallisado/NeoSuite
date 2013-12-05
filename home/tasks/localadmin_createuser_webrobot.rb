require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

describe "Local Admin - Create User", :local => true do

	it "should login to Local Admin" do
		@selenium.login('admin', 'password', 'helpButton-btnIconEl')
		expect { @selenium.title.should eql("ADTRAN Neo") }.to_not raise_error
	end

	it "should create some users on the system" do
		@selenium.login('admin', 'password', 'helpButton-btnIconEl')
		expect { @selenium.title.should eql("ADTRAN Neo") }.to_not raise_error
		sleep 3
		@selenium.click(:xpath, '//*[@id="createUser_wiz"]')
		sleep 2
		@selenium.type(:id, 'createUsersWizardFirstNameField_txtinput-inputEl', 'Automated')
		@selenium.type(:id, 'createUsersWizardLastNameField_txtinput-inputEl', 'User')
		@selenium.type(:id, 'createUsersWizardDescriptionField_txtinput-inputEl', 'Creating user for automated test')
		@selenium.clear(:id, 'createUsersWizardExtensionNumberField_txtinput-inputEl')
		@selenium.type(:id, 'createUsersWizardExtensionNumberField_txtinput-inputEl', '100')
		@selenium.type(:id, 'createUsersWizardCellPhoneField_txtinput-inputEl', '6135550134')
		
		# the next button should be clickable
		@selenium.test_element_present(:xpath, "//*[@id='createUserWiz_next_btn' and contains(@class='x-btn-disabled')]").should eq(false)		
		
		@selenium.click(:xpath, '//*[@id="createUserWiz_next_btn-btnWrap"]')
		
		sleep 3
		@selenium.click(:xpath, '//*[@id="default_radio-inputEl"]')
		
		# the next button should be clickable
		@selenium.test_element_present(:xpath, "//*[@id='createUserWiz_next_btn' and contains(@class='x-btn-disabled')]").should eq(false)		
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
		
		sleep 3
		@selenium.click(:xpath, '//*[@id="createUser_wiz"]')
		sleep 2
		@selenium.type(:id, 'createUsersWizardFirstNameField_txtinput-inputEl', 'Automated')
		@selenium.type(:id, 'createUsersWizardLastNameField_txtinput-inputEl', 'User2')
		@selenium.type(:id, 'createUsersWizardDescriptionField_txtinput-inputEl', 'Creating user for automated test')
		@selenium.clear(:id, 'createUsersWizardExtensionNumberField_txtinput-inputEl')
		@selenium.type(:id, 'createUsersWizardExtensionNumberField_txtinput-inputEl', '101')
    
		# the next button should not be clickable
		@selenium.test_element_present(:xpath, "//*[@id='createUserWiz_next_btn' and contains(@class='x-btn-disabled')]").should eq(false)
		@selenium.click(:xpath, '//*[@id="createUserWiz_next_btn-btnWrap"]')
		
		sleep 3
		@selenium.click(:xpath, '//*[@id="default_radio-inputEl"]')
    
		# the next button should be clickable
		@selenium.test_element_present(:xpath, "//*[@id='createUserWiz_next_btn' and contains(@class='x-btn-disabled')]").should eq(false)
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
