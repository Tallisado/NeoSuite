require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

def wait_for_element_present( how, what, how_long=5)
	p("-- wait_for_element_present [ #{how.to_s}," + what + "," + how_long.to_s + " ]")
	wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long )
	wait_for_it.until { @selenium.find_element(how, what) }
end

describe "PPM Settings", :local => true do
	it "should login to PPM and set/verify the fields in PPM settings" do
		@selenium.navigate.to "http://10.10.9.129/Login/index.php"
		wait_for_element_present(:id, "loginnameid-inputEl", 15)
		@selenium.type(:id, "loginnameid-inputEl", '3011')
		@selenium.type(:id, "loginpasswordid-inputEl", '1234')
		sleep 1
		@selenium.click(:id, "loginbuttonid-btnIconEl")
		@selenium.click(:id, 'settings')

		@selenium.clear(:id, 'profileHomeNumber_field-inputEl')
		@selenium.type(:id, 'profileHomeNumber_field-inputEl', '(613) 599-0100')
		@selenium.clear(:id, 'profileCellNumber_field-inputEl')
		@selenium.type(:id, 'profileCellNumber_field-inputEl', '(613) 333-3007')
		@selenium.clear(:id, 'profilePrimaryEmail_field-inputEl')
		@selenium.type(:id, 'profilePrimaryEmail_field-inputEl', 'Kyle.Turris@senators.nhl.com')
		@selenium.clear(:id, 'profileSecondaryEmail_field-inputEl')
		@selenium.type(:id, 'profileSecondaryEmail_field-inputEl', 'Kyle.Turris@hotmail.com')

		@selenium.click(:xpath, "//div[@id='settingPanel']/div/div/div[2]/div/a[2]")
		@selenium.clear(:id, 'userPassword_input-inputEl')
		@selenium.type(:id, 'userPassword_input-inputEl', '1234')
		@selenium.clear(:id, 'userPasswordReenter_input-inputEl')
		@selenium.type(:id, 'userPasswordReenter_input-inputEl', '1234')
		@selenium.clear(:id, 'voicemailPin_input-inputEl')
		@selenium.type(:id, 'voicemailPin_input-inputEl', '1234')
		@selenium.clear(:id, 'userPinReenter_input-inputEl')
		@selenium.type(:id, 'userPinReenter_input-inputEl', '1234')

		@selenium.click(:xpath, "//div[@id='settingPanel']/div/div/div[2]/div/a[3]")
		@selenium.check(:id, 'playEnvelope_checkbox-inputEl')
		@selenium.check(:id, 'autoPlayMessage_checkbox-inputEl')
		@selenium.click_text_from_combobox(:id, 'greeting_combobox-inputEl', "Standard")
		@selenium.click_text_from_combobox(:id, 'primaryEmailNotification_combobox-inputEl', "Never")
		@selenium.click_text_from_combobox(:id, 'secondaryEmailNotification_combobox-inputEl', "Always")
		@selenium.click_text_from_combobox(:id, 'emailAction_combobox-inputEl', "None")
		@selenium.click(:xpath, '//*[@id="settingOK_btn-btnIconEl"]')

		@selenium.click(:id, 'settings')
		@selenium.verify_attribute_from_element(:id, "profile_img", "src", "/Images/Avatars/unknown.png")
		@selenium.verify_text_from_element(:id, 'profileName_field-inputEl', "Kyle Turris");
		@selenium.verify_text_from_element(:id, 'profileDesc_field-inputEl', "Centre");
		@selenium.verify_text_from_element(:id, 'profileExt_field-inputEl', "3007");
		@selenium.verify_text_from_element(:id, 'profileEmergLoc_field-inputEl', "1000 Palladium Dr. Ottawa, Ontario K2V 1A5 Canada");
		@selenium.verify_text_from_element(:id, 'profileAssignedGroups_field-bodyEl', "");
		@selenium.verify_text_from_element(:id, 'ProfileHelp-inputEl', "Click on a field at the left to see help text");
		@selenium.verify_attribute_from_element(:id, "profileHomeNumber_field-inputEl", "value", "(613) 599-0100")
		@selenium.verify_attribute_from_element(:id, "profileCellNumber_field-inputEl", "value", "(613) 333-3007")
		@selenium.verify_attribute_from_element(:id, "profilePrimaryEmail_field-inputEl", "value", "Kyle.Turris@senators.nhl.com")
		@selenium.verify_attribute_from_element(:id, "profileSecondaryEmail_field-inputEl", "value", "Kyle.Turris@hotmail.com")
		
		@selenium.click(:xpath, "//div[@id='settingPanel']/div/div/div[2]/div/a[2]")
		@selenium.verify_text_from_element(:id, 'PasswordHelp-inputEl', "Click on a field at the left to see help text");
		@selenium.verify_attribute_from_element(:id, "userPassword_input-inputEl", "value", "1234")
		@selenium.verify_attribute_from_element(:id, "userPasswordReenter_input-inputEl", "value", "1234")
		@selenium.verify_attribute_from_element(:id, "voicemailPin_input-inputEl", "value", "1234")
		@selenium.verify_attribute_from_element(:id, "userPinReenter_input-inputEl", "value", "1234")
		
		@selenium.click(:xpath, "//div[@id='settingPanel']/div/div/div[2]/div/a[3]")
		@selenium.verify_text_from_element(:id, 'VMConfigProfileHelp-inputEl', "Click on a field at the left to see help text");
		@selenium.verify_attribute_from_element(:id, "greeting_combobox-inputEl", "value", "Standard")
		@selenium.verify_attribute_from_element(:id, "primaryEmailNotification_combobox-inputEl", "value", "Never")
		@selenium.verify_attribute_from_element(:id, "secondaryEmailNotification_combobox-inputEl", "value", "Always")
		@selenium.verify_attribute_from_element(:id, "emailAction_combobox-inputEl", "value", "None")
	
		@selenium.click(:xpath, "//div[@id='settingPanel']/div/div/div[2]/div/a[6]")
		@selenium.click_text_from_combobox(:id, 'cbGuiLang-inputEl', "French-Canadian")
		@selenium.click_text_from_combobox(:id, 'cbGuiLang-inputEl', "French Canadian")
		@selenium.click(:id, 'settingOK_btn-btnEl')
		sleep 5
		@selenium.click(:id, 'settings')
		@selenium.click(:xpath, "//div[@id='settingPanel']/div/div/div[2]/div/a[6]")
		@selenium.click_text_from_combobox(:id, 'cbGuiLang-inputEl', "English-US")
		@selenium.click_text_from_combobox(:id, 'cbGuiLang-inputEl', "English")
		@selenium.click(:id, 'settingOK_btn-btnEl')
	end
end
