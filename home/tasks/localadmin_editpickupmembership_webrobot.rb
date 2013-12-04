require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

describe "Local Admin - Edit Pickup Membership", :local => true do

	it "should login to Local Admin" do
		@selenium.login('admin', 'password', 'helpButton-btnIconEl')
		expect { @selenium.title.should eql("ADTRAN Neo") }.to_not raise_error
	end

	it "should edit the pickup group membership" do
		@selenium.login('admin', 'password', 'helpButton-btnIconEl')
		expect { @selenium.title.should eql("ADTRAN Neo") }.to_not raise_error
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
