require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

describe "Local Admin - Phones tab", :local => true do
	it "should login to Local Admin" do
		@selenium.login('admin', 'password', 'helpButton-btnIconEl')
		expect { @selenium.title.should eql("ADTRAN Neo") }.to_not raise_error
    end

	it "should switch to the Phones tab" do
		@selenium.login('admin', 'password', 'helpButton-btnIconEl')
		expect { @selenium.title.should eql("ADTRAN Neo") }.to_not raise_error
		sleep 3
		@selenium.click(:id, 'phones_tab-btnEl')
		@selenium.wait_for_element_present(:id, "phones_panel_add_btn-btnEl", 15)
    end
	
	it "should add a phone" do
		@selenium.login('admin', 'password', 'helpButton-btnIconEl')
		expect { @selenium.title.should eql("ADTRAN Neo") }.to_not raise_error
		sleep 3
		@selenium.click(:id, 'phones_tab-btnEl')
		@selenium.wait_for_element_present(:id, "phones_panel_add_btn-btnEl", 15)
		@selenium.click(:id, "phones_panel_add_btn-btnEl")
		sleep 1
		@selenium.click_text_from_combobox(:id, 'addPhoneWindow_model_combobox-inputEl', "Polycom 650")
		@selenium.type(:id, 'addPhoneWindow_mac_txtinput-inputEl', "01:00:5b:5a:33:11")
		@selenium.click(:id, 'addPhoneWindow_save_btn-btnEl')
    end

	it "should remove a phone" do
		@selenium.login('admin', 'password', 'helpButton-btnIconEl')
		expect { @selenium.title.should eql("ADTRAN Neo") }.to_not raise_error
		sleep 3
		@selenium.click(:id, 'phones_tab-btnEl')
		@selenium.wait_for_element_present(:id, "phones_panel_add_btn-btnEl", 15)
		@selenium.click(:xpath, "//*[@id='phones_panel_phones_grid-body']/div/table/tbody/tr[5]")
		sleep 1
		@selenium.click(:id, 'phones_panel_remove_btn-btnEl')
		sleep 1

    end
end
