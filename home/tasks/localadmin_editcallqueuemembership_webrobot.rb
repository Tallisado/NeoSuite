require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")
#
describe "Local Admin - Edit Call Queue", :local => true do
	it "should edit the call queue membership" do
		@selenium.login('admin', 'password', 'helpButton-btnIconEl')
		expect { @selenium.title.should eql("ADTRAN Neo") }.to_not raise_error
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
