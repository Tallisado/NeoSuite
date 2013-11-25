require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

describe "PPM Settings", :local => true do

	it "should login to PPM" do
		@selenium.login('3011', '1234', 'settingsButton')
		expect { @selenium.title.should eql("ADTRAN Neo") }.to_not raise_error
	end

	it "should set and verify settings" do
		@selenium.login('3011', '1234', 'settingsButton')
		expect { @selenium.title.should eql("ADTRAN Neo") }.to_not raise_error

		@selenium.click(:id, 'settingsButton-btnIconEl')
		@selenium.click(:id, 'settingsProfile')
		@selenium.clear(:name, 'HomeNumber')
		@selenium.type(:name, 'HomeNumber', '(613) 599-0100')
		@selenium.clear(:name, 'MobileNumber')
		@selenium.type(:name, 'MobileNumber', '(613) 333-3007')
		@selenium.clear(:name, 'PrimaryEmail')
		@selenium.type(:name, 'PrimaryEmail', 'Kyle.Turris@senators.nhl.com')
		@selenium.clear(:name, 'SecondaryEmail')
		@selenium.type(:name, 'SecondaryEmail', 'Kyle.Turris@hotmail.com')
		@selenium.click(:id, 'saveUserProfileId')

		@selenium.click(:id, 'settingsButton-btnIconEl')
		@selenium.click(:id, 'settingsPassword')
		@selenium.clear(:name, 'userPassword')
		@selenium.type(:name, 'userPassword', '1234')
		@selenium.clear(:name, 'userPasswordReEnter')
		@selenium.type(:name, 'userPasswordReEnter', '1234')
		@selenium.clear(:name, 'voicemailPIN')
		@selenium.type(:name, 'voicemailPIN', '1234')
		@selenium.clear(:name, 'voicemailPINReEnter')
		@selenium.type(:name, 'voicemailPINReEnter', '1234')
		@selenium.click(:id, 'savePasswordId-btnEl')

		@selenium.click(:id, 'settingsButton-btnIconEl')
		sleep 1
		@selenium.click(:id, "settingsVoicemail")
		@selenium.check(:id, 'playEnvelope_checkbox-inputEl')
		@selenium.check(:id, 'autoPlayMessage_checkbox-inputEl')
		@selenium.click_text_from_combobox(:id, 'greeting_combobox-inputEl', "Default")
		@selenium.click_text_from_combobox(:id, 'primaryEmailNotification_combobox-inputEl', "Never")
		@selenium.click_text_from_combobox(:id, 'secondaryEmailNotification_combobox-inputEl', "Always")
		@selenium.click_text_from_combobox(:id, 'emailAction_combobox-inputEl', "None")
		@selenium.click(:id, 'settingVMConfigClose')

		@selenium.click(:id, 'settingsButton-btnIconEl')
		sleep 1
		@selenium.click(:id, 'settingsProfile')
		#@selenium.verify_text_from_element(:id, 'profileName_field-inputEl', "Kyle Turris");
		#@selenium.verify_text_from_element(:id, 'profileDesc_field-inputEl', "Centre");
		#@selenium.verify_text_from_element(:id, 'profileExt_field-inputEl', "3007");
		#@selenium.verify_text_from_element(:id, 'profileEmergLoc_field-inputEl', "1000 Palladium Dr. Ottawa, Ontario K2V 1A5 Canada");
		#@selenium.verify_text_from_element(:id, 'profileAssignedGroups_field-bodyEl', "");
		#@selenium.verify_text_from_element(:id, 'ProfileHelp-inputEl', "Click on a field at the left to see help text");
		@selenium.verify_attribute_from_element(:name, "HomeNumber", "value", "(613) 599-0100")
		@selenium.verify_attribute_from_element(:name, "MobileNumber", "value", "(613) 333-3007")
		@selenium.verify_attribute_from_element(:name, "PrimaryEmail", "value", "Kyle.Turris@senators.nhl.com")
		@selenium.verify_attribute_from_element(:name, "SecondaryEmail", "value", "Kyle.Turris@hotmail.com")

		@selenium.click(:id, 'settingsButton-btnIconEl')
		sleep 1
		@selenium.click(:id, 'settingsPassword-textEl')
		# @selenium.verify_text_from_element(:id, 'PasswordHelp-inputEl', "Click on a field at the left to see help text");
		@selenium.verify_attribute_from_element(:name, "userPassword", "value", "1234")
		@selenium.verify_attribute_from_element(:name, "userPasswordReEnter", "value", "1234")
		@selenium.verify_attribute_from_element(:name, "voicemailPIN", "value", "1234")
		@selenium.verify_attribute_from_element(:name, "voicemailPINReEnter", "value", "1234")
		@selenium.click(:id, 'savePasswordId-btnEl')

		@selenium.click(:id, 'settingsButton-btnIconEl')
		sleep 1
		@selenium.click(:id, "settingsVoicemail")
		# @selenium.verify_text_from_element(:id, 'VMConfigProfileHelp-inputEl', "Click on a field at the left to see help text");
		@selenium.verify_attribute_from_element(:id, "greeting_combobox-inputEl", "value", "Default")
		@selenium.verify_attribute_from_element(:id, "primaryEmailNotification_combobox-inputEl", "value", "Never")
		@selenium.verify_attribute_from_element(:id, "secondaryEmailNotification_combobox-inputEl", "value", "Always")
		@selenium.verify_attribute_from_element(:id, "emailAction_combobox-inputEl", "value", "None")
		@selenium.click(:id, 'settingVMConfigClose')

		# @selenium.click(:id, 'settingsButton-btnIconEl')
		# @selenium.click(:id, 'settingsInternational')
		# @selenium.click_text_from_combobox(:id, 'cbGuiLang-inputEl', "French-Canadian")
		# @selenium.click_text_from_combobox(:id, 'cbTuiLang-inputEl', "French Canadian")
		# @selenium.click(:id, 'settingInternationalClose')
		# sleep 5
		# @selenium.click(:id, 'settingsButton-btnIconEl')
		# @selenium.click(:id, 'settingsInternational')
		# @selenium.click_text_from_combobox(:id, 'cbGuiLang-inputEl', "English-US")
		# @selenium.click_text_from_combobox(:id, 'cbGuiLang-inputEl', "English")
		# @selenium.click(:id, 'settingInternationalClose')
	end
end