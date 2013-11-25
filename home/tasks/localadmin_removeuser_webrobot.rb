require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

describe "Local Admin - Remove User", :local => true do
	it "should remove the specified user" do
		@selenium.login('admin', 'password', 'helpButton-btnIconEl')
		expect { @selenium.title.should eql("ADTRAN Neo") }.to_not raise_error
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
