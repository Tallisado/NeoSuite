require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

def wait_for_element_present( how, what, how_long=5)
	p("-- wait_for_element_present [ #{how.to_s}," + what + "," + how_long.to_s + " ]")
	wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long )
	wait_for_it.until { @selenium.find_element(how, what) }
end

describe "PPM Settings - Phone Dialog (SPRE)", :local => true do
	it "should nagivate to the PPM settings phone dialog" do
		@selenium.navigate.to "http://10.10.9.129/Login/index.php"
		wait_for_element_present(:id, "loginnameid-inputEl", 15)
		@selenium.type(:id, "loginnameid-inputEl", '3011')
		@selenium.type(:id, "loginpasswordid-inputEl", '1234')
		sleep 1
		@selenium.click(:id, "loginbuttonid-btnIconEl")
		sleep 3
		@selenium.click(:id, 'settingsButton')
		@selenium.click(:xpath, "//div[@id='SettingsDialogTabPanelId']/div/div/div[2]/div/a[4]")
		sleep 15
	end
		
	it "should drag and drop SPRE button types to the main button screen and then delete" do
		#@selenium.testheader "SPRE button settings"
		#@selenium.testheader "SPRE Button - System Mode Lunch"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[2]")
		@selenium.click_text_from_combobox(:id, 'select_cmb-inputEl', "Lunch")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Lunch");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - System Mode Night"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[2]")
		@selenium.click_text_from_combobox(:id, 'select_cmb-inputEl', "Night")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Night");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - System Mode Weekend"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[2]")
		@selenium.click_text_from_combobox(:id, 'select_cmb-inputEl', "Weekend")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Weekend");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");

		#@selenium.testheader "SPRE Button - System Mode Override"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[2]")
		@selenium.click_text_from_combobox(:id, 'select_cmb-inputEl', "Override")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Override");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - System Mode Default"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[2]")
		@selenium.click_text_from_combobox(:id, 'select_cmb-inputEl', "Default")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Default");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Billing Code"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[3]")
		@selenium.type(:id, 'number_txt-inputEl', "1234")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "BC");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - System Speed Dial 1"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[4]")
		sleep 5
		@selenium.click_text_from_combobox(:id, 'select_cmb-inputEl', "Speed dial 1")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		sleep 5
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Speed dial 1");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");

		#@selenium.testheader "SPRE Button - System Speed Dial 2"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[4]")
		sleep 5
		@selenium.click_text_from_combobox(:id, 'select_cmb-inputEl', "Speed dial 2")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		sleep 5
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Speed dial 2");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - System Speed Dial 3"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[4]")
		sleep 5
		@selenium.click_text_from_combobox(:id, 'select_cmb-inputEl', "Speed dial 3")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		sleep 5
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Speed dial 3");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Page Overhead"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[5]")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "pageOverhead");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Page Intercom"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[6]")
		@selenium.click_text_from_combobox(:id, 'select_cmb-inputEl', "All zones")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "All zones");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
	    #@selenium.testheader "SPRE Button - Forward Notification Cancel"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[7]")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Forward Notification Cancel");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Call Forward + Extension"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[8]")
		@selenium.type(:id, 'number_txt-inputEl', "1111")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "CallForward");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Call Forward Remote - Placeholder"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[9]")
		@selenium.type(:id, 'ext_txt-inputEl', "3008")
		@selenium.type(:id, 'number_txt-inputEl', "1111")
		@selenium.type(:id, 'password_txt-inputEl', "1234")
		@selenium.type(:id, 'confirm_password_txt-inputEl', "1234")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "CallForward");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Call Forward Cancel"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[10]")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Call Forward Cancel");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Remote Call Forward Cancel"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[11]")
		@selenium.type(:id, 'ext_txt-inputEl', "1111")
		@selenium.type(:id, 'pwd_txt-inputEl', "1234")
		@selenium.type(:id, 'repwd_txt-inputEl', "1234")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Call Forward Cancel");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Door Phone"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[12]")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Door Phone");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Door Unlock"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[13]")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Door Unlock");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");

		#@selenium.testheader "SPRE Button - DND Enable/Disable - On"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[14]")
		@selenium.click_text_from_combobox(:id, 'select_cmb-inputEl', "On")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "On");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");

		#@selenium.testheader "SPRE Button - DND Enable/Disable - Off"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[14]")
		@selenium.click_text_from_combobox(:id, 'select_cmb-inputEl', "Off")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Off");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Pickup Extension"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[15]")
		@selenium.type(:id, 'number_txt-inputEl', "1111")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "PickExt");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Group Login"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[16]")
		@selenium.type(:id, 'number_txt-inputEl', "1111")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "GroupLogin");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Group Logout"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[17]")
		@selenium.type(:id, 'number_txt-inputEl', "1111")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "GroupLogout");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - User Station/Phone Lock"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[18]")
		@selenium.type(:id, 'pwd_txt-inputEl', "1234")
		@selenium.type(:id, 'repwd_txt-inputEl', "1234")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "PhoneLock");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - User Station Unlock"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[19]")
		@selenium.type(:id, 'pwd_txt-inputEl', "1234")
		@selenium.type(:id, 'repwd_txt-inputEl', "1234")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "UserPhoneUnlock");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Program User Speed Dial - Pick up Extension"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[20]")
		@selenium.type(:id, 'number_txt-inputEl', "1111")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Pickup");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Program User Speed Dial - Retrieve park zone"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[20]")
		@selenium.check(:id, 'retrieve-inputEl')
		@selenium.click_text_from_combobox(:id, 'parkzone_cmb-inputEl', "1")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Pickup");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Call User Speed Dial"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[21]")
		sleep 5
		@selenium.click_text_from_combobox(:id, 'select_cmb-inputEl', "Speed dial 1")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		sleep 5
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Speed dial 1");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Block Caller-ID for this call only"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[22]")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Block CallerId");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");

		#@selenium.testheader "SPRE Button - Call Return"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[23]")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Call Return");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Disable Call Waiting on per-call basis"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[24]")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Disable Call Waiting");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Call Last Dialed Number"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[25]")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Redial");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Call Queue Login"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[26]")
		@selenium.type(:id, 'number_txt-inputEl', "1111")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "CallQLogin");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Call Queue Logout"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[27]")
		@selenium.type(:id, 'number_txt-inputEl', "1111")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "CallQLogout");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Call Park + Zone - Placeholder"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[28]")
		@selenium.click_text_from_combobox(:id, 'select_cmb-inputEl', "Park 0")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Park 0");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Held Call Pickup/Park Retrieve - Pick up ext"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");	
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[29]")
		@selenium.type(:id, 'number_txt-inputEl', "3008")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Pickup");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Held Call Pickup/Park Retrieve - Retrieve Park Zone"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[29]")
		@selenium.click(:id, 'retrieve-inputEl')
		@selenium.click_text_from_combobox(:id, 'parkzone_cmb-inputEl', "1")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Pickup");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Send user direct to VM"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");		
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[30]")
		@selenium.type(:id, 'number_txt-inputEl', "3008")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SendToVM");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - CoS Override"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[31]")
		@selenium.type(:id, 'number_txt-inputEl', "1234")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "ClassOfServiceOverride");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Set Message Waiting"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[32]")
		@selenium.type(:id, 'number_txt-inputEl', "3008")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SetMsgWait");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Clear Message Waiting"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[33]")
		@selenium.type(:id, 'number_txt-inputEl', "3008")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "ClearMsgWait");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - AA DND - On"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[34]")
		@selenium.click_text_from_combobox(:id, 'select_cmb-inputEl', "On")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "On");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - AA DND - Off"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[34]")
		@selenium.click_text_from_combobox(:id, 'select_cmb-inputEl', "Off")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Off");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "SPRE Button - Voicemail"	
		@selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[35]")
		@selenium.click(:id, 'spreOK_btn-btnIconEl')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Voice Mail");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Item3"
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
    end
end