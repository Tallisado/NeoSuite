require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

describe "PPM Settings - Phone Dialog", :local => true do		
	it "should drag and drop all button types to the main button screen and then delete" do
		@selenium.login(3011, 1234, 'settingsButton')
		@selenium.click(:id, 'settingsButton')
		sleep 1
		@selenium.click(:id, "settingsPhone")
		sleep 15
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Droppable) Item3 - DND1"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_1', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "DND");
    end
end