require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

describe "Local Admin - Edit Ring Membership", :local => true do
	it "should edit the ring group membership" do
		@selenium.navigate.to "http://10.10.9.129/Login/index.php"
		@selenium.wait_for_element_present(:id, "loginnameid-inputEl", 15)
		@selenium.type(:id, "loginnameid-inputEl", 'admin')
		@selenium.type(:id, "loginpasswordid-inputEl", 'password')
		sleep 1
		@selenium.click(:id, "loginbuttonid-btnIconEl")
		sleep 5
		@selenium.click(:xpath, '//*[@id="editRingMembership_wiz"]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="ringGroupWiz_grid-body"]/div/table/tbody/tr[1]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="ringGroupWiz_next_btn-btnEl"]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="ringGroupUser_gridconfig-body"]/tr[1]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="ringGroupRight_button-btnEl"]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="ringGroupWiz_next_btn-btnEl"]')
		sleep 3
		@selenium.click(:xpath, '//*[@id="ringGroupWiz_save_btn-btnEl"]')
		sleep 3
		@selenium.click(:xpath, '//*[@id="editRingMembership_wiz"]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="ringGroupWiz_grid-body"]/div/table/tbody/tr[1]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="ringGroupWiz_next_btn-btnEl"]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="ringGroupMember_gridconfig-body"]/tr[1]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="ringGroupLeft_button-btnEl"]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="ringGroupWiz_next_btn-btnEl"]')
		sleep 3
		@selenium.click(:xpath, '//*[@id="ringGroupWiz_save_btn"]')
		
		sleep 5
		@selenium.click(:xpath, '//*[@id="editRingMembership_wiz"]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="ringGroupWiz_grid-body"]/div/table/tbody/tr[2]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="ringGroupWiz_next_btn-btnEl"]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="ringGroupUser_gridconfig-body"]/tr[1]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="ringGroupRight_button-btnEl"]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="ringGroupWiz_next_btn-btnEl"]')
		sleep 3
		@selenium.click(:xpath, '//*[@id="ringGroupWiz_save_btn-btnEl"]')
		sleep 3
		@selenium.click(:xpath, '//*[@id="editRingMembership_wiz"]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="ringGroupWiz_grid-body"]/div/table/tbody/tr[2]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="ringGroupWiz_next_btn-btnEl"]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="ringGroupMember_gridconfig-body"]/tr[1]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="ringGroupLeft_button-btnEl"]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="ringGroupWiz_next_btn-btnEl"]')
		sleep 3
		@selenium.click(:xpath, '//*[@id="ringGroupWiz_save_btn"]')
		
		sleep 5
		@selenium.click(:xpath, '//*[@id="editRingMembership_wiz"]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="ringGroupWiz_grid-body"]/div/table/tbody/tr[3]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="ringGroupWiz_next_btn-btnEl"]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="ringGroupUser_gridconfig-body"]/tr[1]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="ringGroupRight_button-btnEl"]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="ringGroupWiz_next_btn-btnEl"]')
		sleep 3
		@selenium.click(:xpath, '//*[@id="ringGroupWiz_save_btn-btnEl"]')
		sleep 3
		@selenium.click(:xpath, '//*[@id="editRingMembership_wiz"]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="ringGroupWiz_grid-body"]/div/table/tbody/tr[3]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="ringGroupWiz_next_btn-btnEl"]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="ringGroupMember_gridconfig-body"]/tr[1]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="ringGroupLeft_button-btnEl"]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="ringGroupWiz_next_btn-btnEl"]')
		sleep 3
		@selenium.click(:xpath, '//*[@id="ringGroupWiz_save_btn"]')
		
		# sleep 5
		# @selenium.click(:xpath, '//*[@id="editRingMembership_wiz"]')
		# sleep 5
		# @selenium.click(:xpath, '//*[@id="ringGroupWiz_grid-body"]/div/table/tbody/tr[4]')
		# sleep 5
		# @selenium.click(:xpath, '//*[@id="ringGroupWiz_next_btn-btnEl"]')
		# sleep 1
		# @selenium.click(:xpath, '//*[@id="ringGroupUser_gridconfig-body"]/tr[1]')
		# sleep 1
		# @selenium.click(:xpath, '//*[@id="ringGroupRight_button-btnEl"]')
		# sleep 1
		# @selenium.click(:xpath, '//*[@id="ringGroupWiz_next_btn-btnEl"]')
		# sleep 3
		# @selenium.click(:xpath, '//*[@id="ringGroupWiz_save_btn-btnEl"]')
		# sleep 3
		# @selenium.click(:xpath, '//*[@id="editRingMembership_wiz"]')
		# sleep 5
		# @selenium.click(:xpath, '//*[@id="ringGroupWiz_grid-body"]/div/table/tbody/tr[4]')
		# sleep 5
		# @selenium.click(:xpath, '//*[@id="ringGroupWiz_next_btn-btnEl"]')
		# sleep 1
		# @selenium.click(:xpath, '//*[@id="ringGroupMember_gridconfig-body"]/tr[1]')
		# sleep 5
		# @selenium.click(:xpath, '//*[@id="ringGroupLeft_button-btnEl"]')
		# sleep 1
		# @selenium.click(:xpath, '//*[@id="ringGroupWiz_next_btn-btnEl"]')
		# sleep 3
		# @selenium.click(:xpath, '//*[@id="ringGroupWiz_save_btn"]')
    end
end
