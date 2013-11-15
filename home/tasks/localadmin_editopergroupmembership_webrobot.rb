require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

def wait_for_element_present( how, what, how_long=5)
	p("-- wait_for_element_present [ #{how.to_s}," + what + "," + how_long.to_s + " ]")
	wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long )
	wait_for_it.until { @selenium.find_element(how, what) }
end

describe "Local Admin - Edit Operator Membership", :local => true do
	it "should test add/remove of the operator group membership" do
		@selenium.navigate.to "http://10.10.9.129/Login/index.php"
		wait_for_element_present(:id, "loginnameid-inputEl", 15)
		@selenium.type(:id, "loginnameid-inputEl", 'admin')
		@selenium.type(:id, "loginpasswordid-inputEl", 'password')
		sleep 1
		@selenium.click(:id, "loginbuttonid-btnIconEl")
		sleep 3
		@selenium.click(:xpath, '//*[@id="editOperatorMembership_wiz"]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="operatorGroupUser_gridconfig-body"]/tr[1]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="operatorGroupRight_button-btnEl"]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="operatorGroupWiz_next_btn-btnIconEl"]')
		sleep 3
		@selenium.click(:xpath, '//*[@id="operatorGroupWiz_save_btn-btnIconEl"]')
		
		@selenium.click(:xpath, '//*[@id="editOperatorMembership_wiz"]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="operatorGroupMember_gridconfig-body"]/tr[1]')
		sleep 5
		@selenium.click(:xpath, '//*[@id="operatorGroupLeft_button-btnEl"]')
		sleep 1
		@selenium.click(:xpath, '//*[@id="operatorGroupWiz_next_btn-btnIconEl"]')
		sleep 3
		@selenium.click(:xpath, '//*[@id="operatorGroupWiz_save_btn-btnIconEl"]')
    end
end
