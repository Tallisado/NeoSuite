require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

def wait_for_element_present( how, what, how_long=5)
	p("-- wait_for_element_present [ #{how.to_s}," + what + "," + how_long.to_s + " ]")
	wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long )
	wait_for_it.until { @selenium.find_element(how, what) }
end

describe "Local Admin - Edit Pickup Membership", :local => true do
	it "should edit the pickup group membership" do
		@selenium.navigate.to "http://10.10.9.129/Login/index.php"
		wait_for_element_present(:id, "loginnameid-inputEl", 15)
		@selenium.type(:id, "loginnameid-inputEl", 'admin')
		@selenium.type(:id, "loginpasswordid-inputEl", 'password')
		sleep 1
		@selenium.click(:id, "loginbuttonid-btnIconEl")
		sleep 3
		@selenium.click(:xpath, '//*[@id="editPickupMembership_wiz"]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="pickupGroupWiz_grid-body"]/div/table/tbody/tr[1]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="pickupGroupWiz_next_btn-btnEl"]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="pickupGroupUser_gridconfig-body"]/tr[1]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="pickupGroupRight_button-btnEl"]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="pickupGroupWiz_next_btn-btnEl"]')
		sleep 3
		@selenium.click(:xpath, '//*[@id="pickupGroupWiz_save_btn-btnEl"]')
		
		# sleep 1
		# @selenium.click(:xpath, '//*[@id="editPickupMembership_wiz"]')
		# sleep 5
		# @selenium.click(:xpath, '//*[@id="pickupGroupWiz_grid-body"]/div/table/tbody/tr[1]')
		# sleep 5
		# @selenium.click(:xpath, '//*[@id="pickupGroupWiz_next_btn-btnEl"]')
		# sleep 1
		# @selenium.click(:xpath, '//*[@id="pickupGroupMember_gridconfig-body"]/tr[1]')
		# sleep 1
		# @selenium.click(:xpath, '//*[@id="pickupGroupLeft_button-btnEl"]')
		# sleep 1
		# @selenium.click(:xpath, '//*[@id="pickupGroupWiz_next_btn-btnEl"]')
		# sleep 3
		# @selenium.click(:xpath, '//*[@id="pickupGroupWiz_save_btn-btnEl"]')
    end
end
