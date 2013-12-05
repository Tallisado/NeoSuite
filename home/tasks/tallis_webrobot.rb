require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

describe "Sandbox UI test", :local => true do

       it "should run the ui test" do
              @selenium.login('admin', 'password', 'helpButton-btnIconEl')
              expect { @selenium.title.should eql("ADTRAN Neo") }.to_not raise_error
              sleep 3
              @selenium.click(:xpath, '//*[@id="createUser_wiz"]')
              sleep 2
              @selenium.type(:id, 'createUsersWizardFirstNameField_txtinput-inputEl', 'Automated')
              @selenium.type(:id, 'createUsersWizardLastNameField_txtinput-inputEl', 'User')
              @selenium.type(:id, 'createUsersWizardDescriptionField_txtinput-inputEl', 'Creating user for automated test')
              @selenium.clear(:id, 'createUsersWizardExtensionNumberField_txtinput-inputEl')
              @selenium.type(:id, 'createUsersWizardExtensionNumberField_txtinput-inputEl', '1001')
							@selenium.test_element_present(:xpath, "//*[@id='createUserWiz_next_btn-btnIconEl' and contains(@class='x-btn-disabled')]").should eq(false)              
       end
end
