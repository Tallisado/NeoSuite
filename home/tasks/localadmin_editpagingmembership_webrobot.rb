require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

describe "Local Admin - Edit Paging Membership", :local => true do
	it "should edit the paging group membership" do
		@selenium.navigate.to "http://10.10.9.129/Login/index.php"
		@selenium.wait_for_element_present(:id, "loginnameid-inputEl", 15)
		@selenium.type(:id, "loginnameid-inputEl", 'admin')
		@selenium.type(:id, "loginpasswordid-inputEl", 'password')
		sleep 1
		@selenium.click(:id, "loginbuttonid-btnIconEl")
		sleep 3
		@selenium.click(:xpath, '//*[@id="editPagingMembership_wiz"]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="pagingGroupWiz_grid-body"]/div/table/tbody/tr[1]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="pagingGroupWiz_next_btn-btnEl"]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="pagingGroupUser_gridconfig-body"]/tr[1]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="pagingGroupRight_button-btnIconEl"]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="pagingGroupWiz_next_btn-btnEl"]')
		sleep 3
		@selenium.click(:xpath, '//*[@id="pagingGroupWiz_save_btn-btnEl"]')
		
		# sleep 1
		# @selenium.click(:xpath, '//*[@id="editPagingMembership_wiz"]')
		# sleep 5
		# @selenium.click(:xpath, '//*[@id="pagingGroupWiz_grid-body"]/div/table/tbody/tr[1]')
		# sleep 5
		# @selenium.click(:xpath, '//*[@id="pagingGroupWiz_next_btn-btnEl"]')
		# sleep 1
		# @selenium.click(:xpath, '//*[@id="pagingGroupMember_gridconfig-body"]/tr[1]')
		# sleep 1
		# @selenium.click(:xpath, '//*[@id="pagingGroupLeft_button-btnEl"]')
		# sleep 1
		# @selenium.click(:xpath, '//*[@id="pagingGroupWiz_next_btn-btnEl"]')
		# sleep 3
		# @selenium.click(:xpath, '//*[@id="pagingGroupWiz_save_btn-btnEl"]')
    end
end
