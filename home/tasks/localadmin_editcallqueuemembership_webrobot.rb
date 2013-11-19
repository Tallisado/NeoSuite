require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

describe "Local Admin - Edit Call Queue", :local => true do
	it "should edit the call queue membership" do
		@selenium.navigate.to "http://10.10.9.129/Login/index.php"
		@selenium.wait_for_element_present(:id, "loginnameid-inputEl", 15)
		@selenium.type(:id, "loginnameid-inputEl", 'admin')
		@selenium.type(:id, "loginpasswordid-inputEl", 'password')
		sleep 1
		@selenium.click(:id, "loginbuttonid-btnIconEl")
		sleep 3
		@selenium.click(:xpath, '//*[@id="editCallQueueMembership_wiz"]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="callQueueGroupWiz_grid-body"]/div/table/tbody/tr[1]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="callQueueGroupWiz_next_btn"]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="callQueueGroupUser_gridconfig-body"]/tr[1]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="callQueueGroupRight_button-btnEl"]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="callQueueGroupUser_gridconfig-body"]/tr[2]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="callQueueGroupRight_button-btnEl"]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="callQueueGroupWiz_next_btn-btnEl"]')
		sleep 3
		@selenium.click(:xpath, '//*[@id="callQueueGroupWiz_save_btn-btnIconEl"]')
		
		sleep 1
		@selenium.click(:xpath, '//*[@id="editCallQueueMembership_wiz"]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="callQueueGroupWiz_grid-body"]/div/table/tbody/tr[1]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="callQueueGroupWiz_next_btn"]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="callQueueGroupMember_gridconfig-body"]/tr[1]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="callQueueGroupLeft_button-btnEl"]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="callQueueGroupMember_gridconfig-body"]/tr[1]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="callQueueGroupLeft_button-btnEl"]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="callQueueGroupWiz_next_btn-btnEl"]')
		sleep 3
		@selenium.click(:xpath, '//*[@id="callQueueGroupWiz_save_btn-btnIconEl"]')
    end
end
