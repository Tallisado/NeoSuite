require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

describe "Local Admin - Edit Paging Membership", :local => true do

	it "should login to Local Admin" do
		@selenium.login('admin', 'password', 'helpButton-btnIconEl')
		expect { @selenium.title.should eql("ADTRAN Neo") }.to_not raise_error
	end

	it "should edit the paging group membership" do
		@selenium.login('admin', 'password', 'helpButton-btnIconEl')
		expect { @selenium.title.should eql("ADTRAN Neo") }.to_not raise_error
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
