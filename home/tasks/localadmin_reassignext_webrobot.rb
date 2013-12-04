require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

describe "Local Admin - Reassign Extension", :local => true do

	it "should login to Local Admin" do
		@selenium.login('admin', 'password', 'helpButton-btnIconEl')
		expect { @selenium.title.should eql("ADTRAN Neo") }.to_not raise_error
	end

	it "should test reassigning an extension" do
		@selenium.login('admin', 'password', 'helpButton-btnIconEl')
		expect { @selenium.title.should eql("ADTRAN Neo") }.to_not raise_error
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
