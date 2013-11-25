require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

describe "Change Password", :local => true do
	it "should reset user passwords" do
		@selenium.login('admin', 'password', 'helpButton-btnIconEl')
		expect { @selenium.title.should eql("ADTRAN Neo") }.to_not raise_error
		sleep 3
		
		@selenium.click(:xpath, '//*[@id="changePassword_wiz"]')
		@selenium.click_text_from_combobox(:id, 'changePassWiz_comboBox-inputEl', "Automated User")
		@selenium.click(:xpath, '//*[@id="changePasswordWizard_next_btn-btnIconEl"]')
		sleep 2
		@selenium.check(:xpath, '//*[@id="changePassWiz_card-1_wizPanelForm-innerCt"]/table/tbody/tr/td[2]/div/div/div/table[1]/tbody/tr/td[2]/input[1]')
		@selenium.click(:xpath, '//*[@id="changePasswordWizard_next_btn-btnIconEl"]')
		sleep 2
		@selenium.click(:xpath, '//*[@id="changePasswordWizard_save_btn-btnIconEl"]')
		sleep 2

		@selenium.click(:xpath, '//*[@id="changePassword_wiz"]')
		@selenium.click_text_from_combobox(:id, 'changePassWiz_comboBox-inputEl', "Automated User")
		@selenium.click(:xpath, '//*[@id="changePasswordWizard_next_btn-btnIconEl"]')
		sleep 2
		@selenium.check(:xpath, '//*[@id="changePassWiz_card-1_wizPanelForm-innerCt"]/table/tbody/tr/td[2]/div/div/div/table[2]/tbody/tr/td[2]/input[1]')
		@selenium.click(:xpath, '//*[@id="changePasswordWizard_next_btn-btnIconEl"]')
		sleep 2
		@selenium.click(:xpath, '//*[@id="changePasswordWizard_save_btn-btnIconEl"]')
		sleep 2

		@selenium.click(:xpath, '//*[@id="changePassword_wiz"]')
		@selenium.click_text_from_combobox(:id, 'changePassWiz_comboBox-inputEl', "Automated User")
		@selenium.click(:xpath, '//*[@id="changePasswordWizard_next_btn-btnIconEl"]')
		sleep 2
		@selenium.check(:xpath, '//*[@id="changePassWiz_card-1_wizPanelForm-innerCt"]/table/tbody/tr/td[2]/div/div/div/table[3]/tbody/tr/td[2]/input[1]')
		@selenium.click(:xpath, '//*[@id="changePasswordWizard_next_btn-btnIconEl"]')
		sleep 2
		@selenium.click(:xpath, '//*[@id="changePasswordWizard_save_btn-btnIconEl"]')
		sleep 2

		@selenium.click(:xpath, '//*[@id="changePassword_wiz"]')
		@selenium.click_text_from_combobox(:id, 'changePassWiz_comboBox-inputEl', "Automated User")
		@selenium.click(:xpath, '//*[@id="changePasswordWizard_next_btn-btnIconEl"]')
		sleep 2
		@selenium.check(:xpath, '//*[@id="changePassWiz_card-1_wizPanelForm-innerCt"]/table/tbody/tr/td[2]/div/div/div/table[4]/tbody/tr/td[2]/input[1]')
		@selenium.click(:xpath, '//*[@id="changePasswordWizard_next_btn-btnIconEl"]')
		sleep 2
		@selenium.click(:xpath, '//*[@id="changePasswordWizard_save_btn-btnIconEl"]')		
    end
end
