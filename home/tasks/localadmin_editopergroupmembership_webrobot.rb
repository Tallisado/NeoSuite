require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

describe "Local Admin - Edit Operator Membership", :local => true do
	it "should test add/remove of the operator group membership" do
		@selenium.login('admin', 'password', 'helpButton-btnIconEl')
		expect { @selenium.title.should eql("ADTRAN Neo") }.to_not raise_error
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
