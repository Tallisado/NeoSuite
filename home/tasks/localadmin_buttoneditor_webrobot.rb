require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

describe "Local Admin - Button Editor", :local => true do
	it "should drag and drop button types" do
		@selenium.login('admin', 'password', 'helpButton-btnIconEl')
		expect { @selenium.title.should eql("ADTRAN Neo") }.to_not raise_error
		sleep 3
		@selenium.click(:xpath, '//*[@id="editPhoneButton_wiz"]')
		
		@selenium.click_text_from_combobox(:id, 'phonebuttonWizard_comboBox-inputEl', "Chris Phillips")
		@selenium.click(:xpath, '//*[@id="launchPhoneWiz_launchEditor_btn-btnEl"]')
		sleep 5
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Default Setting)"
		@selenium.verify_text_from_element(:id, 'phone_btn0_lbl', "line 1");
		@selenium.verify_text_from_element(:id, 'phone_btn1_lbl', "line 2");
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		@selenium.verify_text_from_element(:id, 'phone_btn3_lbl', "");
		@selenium.verify_text_from_element(:id, 'phone_btn4_lbl', "");
		@selenium.verify_text_from_element(:id, 'phone_btn5_lbl', "");
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Droppable) Item3 - DND1"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_1', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "DND");

		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Droppable) Item4 - DND2"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_1', :id, 'phone_btn3')		
		@selenium.verify_text_from_element(:id, 'phone_btn3_lbl', "DND");
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Droppable) Item5 - DND3"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_1', :id, 'phone_btn4')		
		@selenium.verify_text_from_element(:id, 'phone_btn4_lbl', "DND");

		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Droppable) Item6 - DND4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_1', :id, 'phone_btn5')		
		@selenium.verify_text_from_element(:id, 'phone_btn5_lbl', "DND");
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Item3"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Item4"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Item5"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Item6"
		@selenium.click_by_script('phone_btn5_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn5_lbl', "");			
		@selenium.click_by_script('phone_btn4_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn4_lbl', "");	
		@selenium.click_by_script('phone_btn3_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn3_lbl', "");	
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (DND) Draggable, Droppable and Delete [Menu Slot 6] - DND5"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_1', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "DND");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (Blank) Draggable, Droppable and Delete [Menu Slot 6]"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_2', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Blank");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		# #@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (SPRE) Draggable, Droppable and Delete [Menu Slot 6]"		
		# @selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn2')		
		# @selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "SPRE");
		# @selenium.double_click(:id, "phone_btn2_lbl")
		# @selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[1]")
		# @selenium.click(:id, 'spreOK_btn-btnIconEl')
		# @selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Hand Free Auto Answer");
		# @selenium.click_by_script('phone_btn2_del-innerCt')
		# @selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (System Schedule) Draggable, Droppable and Delete [Menu Slot 6]"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_4', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "System Schedule");
		@selenium.double_click(:id, "phone_btn2_lbl")
		sleep 10
		@selenium.click_text_from_combobox(:id, 'systemschedule_combobox-inputEl', "Lunch")
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (User) Draggable, Droppable and Delete [Menu Slot 6]"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_5', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "User");
		@selenium.double_click(:id, "phone_btn2_lbl")
		@selenium.click_text_from_combobox(:id, 'user_combobox-inputEl', "Chris Neil Cell")
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");		
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (Mailbox) Draggable, Droppable and Delete [Menu Slot 6]"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_6', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Mailbox");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");		
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (Speed Dial) Draggable, Droppable and Delete [Menu Slot 6]"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_7', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Speed Dial");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");		
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (Park Zone) Draggable, Droppable and Delete [Menu Slot 6]"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_8', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Park Zone");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");		
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (Paging Group) Draggable, Droppable and Delete [Menu Slot 6] --1"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_9', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "Paging Group");
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (DND) Draggable, Droppable and Delete [Menu Slot 6] - DND6"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_1', :id, 'phone_btn2')		
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "DND");
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (Blank) Draggable, Droppable and Delete [Menu Slot 6]"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_2', :id, 'phone_btn3')		
		@selenium.verify_text_from_element(:id, 'phone_btn3_lbl', "Blank");
		@selenium.click_by_script('phone_btn3_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn3_lbl', "");
		
		# #@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (SPRE) Draggable, Droppable and Delete [Menu Slot 6]"		
		# @selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn3')		
		# @selenium.verify_text_from_element(:id, 'phone_btn3_lbl', "SPRE");
		# @selenium.double_click(:id, "phone_btn3_lbl")
		# @selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[1]")
		# @selenium.click(:id, 'spreOK_btn-btnIconEl')
		# @selenium.verify_text_from_element(:id, 'phone_btn3_lbl', "Hand Free Auto Answer");
		# @selenium.click_by_script('phone_btn3_del-innerCt')
		# @selenium.verify_text_from_element(:id, 'phone_btn3_lbl', "");
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (System Schedule) Draggable, Droppable and Delete [Menu Slot 6]"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_4', :id, 'phone_btn3')		
		@selenium.verify_text_from_element(:id, 'phone_btn3_lbl', "System Schedule");
		@selenium.double_click(:id, "phone_btn3_lbl")
		sleep 10
		@selenium.click_text_from_combobox(:id, 'systemschedule_combobox-inputEl', "Lunch")
		@selenium.click_by_script('phone_btn3_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn3_lbl', "");
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (User) Draggable, Droppable and Delete [Menu Slot 6]"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_5', :id, 'phone_btn3')		
		@selenium.verify_text_from_element(:id, 'phone_btn3_lbl', "User");
		@selenium.double_click(:id, "phone_btn3_lbl")
		@selenium.click_text_from_combobox(:id, 'user_combobox-inputEl', "Chris Neil Cell")
		@selenium.click_by_script('phone_btn3_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn3_lbl', "");		
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (Mailbox) Draggable, Droppable and Delete [Menu Slot 6]"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_6', :id, 'phone_btn3')		
		@selenium.verify_text_from_element(:id, 'phone_btn3_lbl', "Mailbox");
		@selenium.click_by_script('phone_btn3_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn3_lbl', "");		
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (Speed Dial) Draggable, Droppable and Delete [Menu Slot 6]"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_7', :id, 'phone_btn3')		
		@selenium.verify_text_from_element(:id, 'phone_btn3_lbl', "Speed Dial");
		@selenium.click_by_script('phone_btn3_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn3_lbl', "");		
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (Park Zone) Draggable, Droppable and Delete [Menu Slot 6]"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_8', :id, 'phone_btn3')		
		@selenium.verify_text_from_element(:id, 'phone_btn3_lbl', "Park Zone");
		@selenium.click_by_script('phone_btn3_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn3_lbl', "");		
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (Paging Group) Draggable, Droppable and Delete [Menu Slot 6] --2"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_9', :id, 'phone_btn3')		
		@selenium.verify_text_from_element(:id, 'phone_btn3_lbl', "Paging Group");
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (DND) Draggable, Droppable and Delete [Menu Slot 6] - DND7"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_1', :id, 'phone_btn4')		
		@selenium.verify_text_from_element(:id, 'phone_btn4_lbl', "DND");
		@selenium.click_by_script('phone_btn4_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn4_lbl', "");
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (Blank) Draggable, Droppable and Delete [Menu Slot 6]"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_2', :id, 'phone_btn4')		
		@selenium.verify_text_from_element(:id, 'phone_btn4_lbl', "Blank");
		@selenium.click_by_script('phone_btn4_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn4_lbl', "");
		
		# #@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (SPRE) Draggable, Droppable and Delete [Menu Slot 6]"		
		# @selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn4')		
		# @selenium.verify_text_from_element(:id, 'phone_btn4_lbl', "SPRE");
		# @selenium.double_click(:id, "phone_btn4_lbl")
		# @selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[1]")
		# @selenium.click(:id, 'spreOK_btn-btnIconEl')
		# @selenium.verify_text_from_element(:id, 'phone_btn4_lbl', "Hand Free Auto Answer");
		# @selenium.click_by_script('phone_btn4_del-innerCt')
		# @selenium.verify_text_from_element(:id, 'phone_btn4_lbl', "");
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (System Schedule) Draggable, Droppable and Delete [Menu Slot 6]"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_4', :id, 'phone_btn4')		
		@selenium.verify_text_from_element(:id, 'phone_btn4_lbl', "System Schedule");
		@selenium.double_click(:id, "phone_btn4_lbl")
		sleep 10
		@selenium.click_text_from_combobox(:id, 'systemschedule_combobox-inputEl', "Lunch")
		@selenium.click_by_script('phone_btn4_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn4_lbl', "");
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (User) Draggable, Droppable and Delete [Menu Slot 6]"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_5', :id, 'phone_btn4')		
		@selenium.verify_text_from_element(:id, 'phone_btn4_lbl', "User");
		@selenium.click_by_script('phone_btn4_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn4_lbl', "");		
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (Mailbox) Draggable, Droppable and Delete [Menu Slot 6]"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_6', :id, 'phone_btn4')		
		@selenium.verify_text_from_element(:id, 'phone_btn4_lbl', "Mailbox");
		@selenium.click_by_script('phone_btn4_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn4_lbl', "");		
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (Speed Dial) Draggable, Droppable and Delete [Menu Slot 6]"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_7', :id, 'phone_btn4')		
		@selenium.verify_text_from_element(:id, 'phone_btn4_lbl', "Speed Dial");
		@selenium.click_by_script('phone_btn4_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn4_lbl', "");		
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (Park Zone) Draggable, Droppable and Delete [Menu Slot 6]"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_8', :id, 'phone_btn4')		
		@selenium.verify_text_from_element(:id, 'phone_btn4_lbl', "Park Zone");
		@selenium.click_by_script('phone_btn4_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn4_lbl', "");		
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (Paging Group) Draggable, Droppable and Delete [Menu Slot 6] --3"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_9', :id, 'phone_btn4')		
		@selenium.verify_text_from_element(:id, 'phone_btn4_lbl', "Paging Group");
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (DND) Draggable, Droppable and Delete [Menu Slot 6] - DND8"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_1', :id, 'phone_btn5')		
		@selenium.verify_text_from_element(:id, 'phone_btn5_lbl', "DND");
		@selenium.click_by_script('phone_btn5_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn5_lbl', "");
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (Blank) Draggable, Droppable and Delete [Menu Slot 6]"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_2', :id, 'phone_btn5')		
		@selenium.verify_text_from_element(:id, 'phone_btn5_lbl', "Blank");
		@selenium.click_by_script('phone_btn5_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn5_lbl', "");
		
		# #@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (SPRE) Draggable, Droppable and Delete [Menu Slot 6]"		
		# @selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'phone_btn5')		
		# @selenium.verify_text_from_element(:id, 'phone_btn5_lbl', "SPRE");
		# @selenium.double_click(:id, "phone_btn5_lbl")
		# @selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[1]")
		# @selenium.click(:id, 'spreOK_btn-btnIconEl')
		# @selenium.verify_text_from_element(:id, 'phone_btn5_lbl', "Hand Free Auto Answer");
		# @selenium.click_by_script('phone_btn5_del-innerCt')
		# @selenium.verify_text_from_element(:id, 'phone_btn5_lbl', "");
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (System Schedule) Draggable, Droppable and Delete [Menu Slot 6]"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_4', :id, 'phone_btn5')		
		@selenium.verify_text_from_element(:id, 'phone_btn5_lbl', "System Schedule");
		@selenium.double_click(:id, "phone_btn5_lbl")
		sleep 10
		@selenium.click_text_from_combobox(:id, 'systemschedule_combobox-inputEl', "Lunch")
		@selenium.click_by_script('phone_btn5_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn5_lbl', "");
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (User) Draggable, Droppable and Delete [Menu Slot 6]"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_5', :id, 'phone_btn5')		
		@selenium.verify_text_from_element(:id, 'phone_btn5_lbl', "User");
		@selenium.click_by_script('phone_btn5_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn5_lbl', "");		
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (Mailbox) Draggable, Droppable and Delete [Menu Slot 6]"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_6', :id, 'phone_btn5')		
		@selenium.verify_text_from_element(:id, 'phone_btn5_lbl', "Mailbox");
		@selenium.click_by_script('phone_btn5_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn5_lbl', "");		
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (Speed Dial) Draggable, Droppable and Delete [Menu Slot 6]"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_7', :id, 'phone_btn5')		
		@selenium.verify_text_from_element(:id, 'phone_btn5_lbl', "Speed Dial");
		@selenium.click_by_script('phone_btn5_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn5_lbl', "");		
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (Park Zone) Draggable, Droppable and Delete [Menu Slot 6]"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_8', :id, 'phone_btn5')		
		@selenium.verify_text_from_element(:id, 'phone_btn5_lbl', "Park Zone");
		@selenium.click_by_script('phone_btn5_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn5_lbl', "");		
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Drag-And-Drop (Paging Group) Draggable, Droppable and Delete [Menu Slot 6]"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_9', :id, 'phone_btn5')		
		@selenium.verify_text_from_element(:id, 'phone_btn5_lbl', "Paging Group");
		@selenium.click_by_script('phone_btn5_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn5_lbl', "");	
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Item3"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Item4"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Item5"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Item6"
		@selenium.click_by_script('phone_btn5_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn5_lbl', "");			
		@selenium.click_by_script('phone_btn4_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn4_lbl', "");	
		@selenium.click_by_script('phone_btn3_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn3_lbl', "");	
		@selenium.click_by_script('phone_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'phone_btn2_lbl', "");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1)"
		@selenium.click(:id, 'expansionbtn1_tab-btnInnerEl')
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Default Setting)"
		@selenium.verify_text_from_element(:id, 'exp1_btn0_lbl', "");
		@selenium.verify_text_from_element(:id, 'exp1_btn1_lbl', "");
		@selenium.verify_text_from_element(:id, 'exp1_btn3_lbl', "");
		@selenium.verify_text_from_element(:id, 'exp1_btn3_lbl', "");
		@selenium.verify_text_from_element(:id, 'exp1_btn4_lbl', "");
		@selenium.verify_text_from_element(:id, 'exp1_btn5_lbl', "");
		@selenium.verify_text_from_element(:id, 'exp1_btn6_lbl', "");
		@selenium.verify_text_from_element(:id, 'exp1_btn7_lbl', "");
		@selenium.verify_text_from_element(:id, 'exp1_btn8_lbl', "");
		@selenium.verify_text_from_element(:id, 'exp1_btn9_lbl', "");
		@selenium.verify_text_from_element(:id, 'exp1_btn10_lbl', "");
		@selenium.verify_text_from_element(:id, 'exp1_btn11_lbl', "");
		@selenium.verify_text_from_element(:id, 'exp1_btn12_lbl', "");
		@selenium.verify_text_from_element(:id, 'exp1_btn13_lbl', "");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item1"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_1', :id, 'exp1_btn0')		
		@selenium.verify_text_from_element(:id, 'exp1_btn0_lbl', "DND");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item1"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_1', :id, 'exp1_btn1')		
		@selenium.verify_text_from_element(:id, 'exp1_btn1_lbl', "DND");

		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item1"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_1', :id, 'exp1_btn2')		
		@selenium.verify_text_from_element(:id, 'exp1_btn2_lbl', "DND");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item1"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_1', :id, 'exp1_btn3')		
		@selenium.verify_text_from_element(:id, 'exp1_btn3_lbl', "DND");

		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item1"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_1', :id, 'exp1_btn4')		
		@selenium.verify_text_from_element(:id, 'exp1_btn4_lbl', "DND");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item1"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_1', :id, 'exp1_btn5')		
		@selenium.verify_text_from_element(:id, 'exp1_btn5_lbl', "DND");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item1"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_1', :id, 'exp1_btn6')		
		@selenium.verify_text_from_element(:id, 'exp1_btn6_lbl', "DND");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item1"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_1', :id, 'exp1_btn7')		
		@selenium.verify_text_from_element(:id, 'exp1_btn7_lbl', "DND");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item1"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_1', :id, 'exp1_btn8')		
		@selenium.verify_text_from_element(:id, 'exp1_btn8_lbl', "DND");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item1"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_1', :id, 'exp1_btn9')		
		@selenium.verify_text_from_element(:id, 'exp1_btn9_lbl', "DND");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item1"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_1', :id, 'exp1_btn10')		
		@selenium.verify_text_from_element(:id, 'exp1_btn10_lbl', "DND");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item1"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_1', :id, 'exp1_btn11')		
		@selenium.verify_text_from_element(:id, 'exp1_btn11_lbl', "DND");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item1"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_1', :id, 'exp1_btn12')		
		@selenium.verify_text_from_element(:id, 'exp1_btn12_lbl', "DND");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item1"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_1', :id, 'exp1_btn13')		
		@selenium.verify_text_from_element(:id, 'exp1_btn13_lbl', "DND");
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 14"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 13"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 12"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 11"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 10"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 9"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 8"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 7"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 6"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 5"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 4"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 3"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 2"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 1"
		@selenium.click_by_script('exp1_btn13_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn13_lbl', "");
		@selenium.click_by_script('exp1_btn12_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn12_lbl', "");		
		@selenium.click_by_script('exp1_btn11_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn11_lbl', "");			
		@selenium.click_by_script('exp1_btn10_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn10_lbl', "");	
		@selenium.click_by_script('exp1_btn9_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn9_lbl', "");	
		@selenium.click_by_script('exp1_btn8_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn8_lbl', "");
		@selenium.click_by_script('exp1_btn7_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn7_lbl', "");
		@selenium.click_by_script('exp1_btn6_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn6_lbl', "");
		@selenium.click_by_script('exp1_btn5_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn5_lbl', "");			
		@selenium.click_by_script('exp1_btn4_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn4_lbl', "");	
		@selenium.click_by_script('exp1_btn3_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn3_lbl', "");	
		@selenium.click_by_script('exp1_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn2_lbl', "");
		@selenium.click_by_script('exp1_btn1_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn1_lbl', "");
		@selenium.click_by_script('exp1_btn0_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn0_lbl', "");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item2"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_2', :id, 'exp1_btn0')		
		@selenium.verify_text_from_element(:id, 'exp1_btn0_lbl', "Blank");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item2"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_2', :id, 'exp1_btn1')		
		@selenium.verify_text_from_element(:id, 'exp1_btn1_lbl', "Blank");

		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item2"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_2', :id, 'exp1_btn2')		
		@selenium.verify_text_from_element(:id, 'exp1_btn2_lbl', "Blank");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item2"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_2', :id, 'exp1_btn3')		
		@selenium.verify_text_from_element(:id, 'exp1_btn3_lbl', "Blank");

		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item2"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_2', :id, 'exp1_btn4')		
		@selenium.verify_text_from_element(:id, 'exp1_btn4_lbl', "Blank");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item2"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_2', :id, 'exp1_btn5')		
		@selenium.verify_text_from_element(:id, 'exp1_btn5_lbl', "Blank");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item2"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_2', :id, 'exp1_btn6')		
		@selenium.verify_text_from_element(:id, 'exp1_btn6_lbl', "Blank");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item2"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_2', :id, 'exp1_btn7')		
		@selenium.verify_text_from_element(:id, 'exp1_btn7_lbl', "Blank");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item2"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_2', :id, 'exp1_btn8')		
		@selenium.verify_text_from_element(:id, 'exp1_btn8_lbl', "Blank");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item2"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_2', :id, 'exp1_btn9')		
		@selenium.verify_text_from_element(:id, 'exp1_btn9_lbl', "Blank");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item2"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_2', :id, 'exp1_btn10')		
		@selenium.verify_text_from_element(:id, 'exp1_btn10_lbl', "Blank");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item2"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_2', :id, 'exp1_btn11')		
		@selenium.verify_text_from_element(:id, 'exp1_btn11_lbl', "Blank");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item2"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_2', :id, 'exp1_btn12')		
		@selenium.verify_text_from_element(:id, 'exp1_btn12_lbl', "Blank");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item2"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_2', :id, 'exp1_btn13')		
		@selenium.verify_text_from_element(:id, 'exp1_btn13_lbl', "Blank");
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 14"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 13"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 12"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 11"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 10"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 9"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 8"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 7"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 6"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 5"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 4"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 3"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 2"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 1"
		@selenium.click_by_script('exp1_btn13_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn13_lbl', "");
		@selenium.click_by_script('exp1_btn12_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn12_lbl', "");		
		@selenium.click_by_script('exp1_btn11_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn11_lbl', "");			
		@selenium.click_by_script('exp1_btn10_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn10_lbl', "");	
		@selenium.click_by_script('exp1_btn9_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn9_lbl', "");	
		@selenium.click_by_script('exp1_btn8_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn8_lbl', "");
		@selenium.click_by_script('exp1_btn7_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn7_lbl', "");
		@selenium.click_by_script('exp1_btn6_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn6_lbl', "");
		@selenium.click_by_script('exp1_btn5_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn5_lbl', "");			
		@selenium.click_by_script('exp1_btn4_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn4_lbl', "");	
		@selenium.click_by_script('exp1_btn3_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn3_lbl', "");	
		@selenium.click_by_script('exp1_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn2_lbl', "");
		@selenium.click_by_script('exp1_btn1_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn1_lbl', "");
		@selenium.click_by_script('exp1_btn0_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn0_lbl', "");
		
		# #@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item3"				
		# @selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'exp1_btn0')		
		# @selenium.verify_text_from_element(:id, 'exp1_btn0_lbl', "SPRE");
		# @selenium.double_click(:id, "exp1_btn0_lbl")
		# @selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[1]")
		# @selenium.click(:id, 'spreOK_btn-btnIconEl')
		# @selenium.verify_text_from_element(:id, 'exp1_btn0_lbl', "Hand Free Auto Answer");
		
		# #@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item3"				
		# @selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'exp1_btn1')		
		# @selenium.verify_text_from_element(:id, 'exp1_btn1_lbl', "SPRE");
		# @selenium.double_click(:id, "exp1_btn1_lbl")
		# @selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[1]")
		# @selenium.click(:id, 'spreOK_btn-btnIconEl')
		# @selenium.verify_text_from_element(:id, 'exp1_btn1_lbl', "Hand Free Auto Answer");
		
		# #@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item3"				
		# @selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'exp1_btn2')		
		# @selenium.verify_text_from_element(:id, 'exp1_btn2_lbl', "SPRE");
		# @selenium.double_click(:id, "exp1_btn2_lbl")
		# @selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[1]")
		# @selenium.click(:id, 'spreOK_btn-btnIconEl')
		# @selenium.verify_text_from_element(:id, 'exp1_btn2_lbl', "Hand Free Auto Answer");
		
		# #@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item3"				
		# @selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'exp1_btn3')		
		# @selenium.verify_text_from_element(:id, 'exp1_btn3_lbl', "SPRE");
		# @selenium.double_click(:id, "exp1_btn3_lbl")
		# @selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[1]")
		# @selenium.click(:id, 'spreOK_btn-btnIconEl')
		# @selenium.verify_text_from_element(:id, 'exp1_btn3_lbl', "Hand Free Auto Answer");
		
		# #@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item3"				
		# @selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'exp1_btn4')		
		# @selenium.verify_text_from_element(:id, 'exp1_btn4_lbl', "SPRE");
		# @selenium.double_click(:id, "exp1_btn4_lbl")
		# @selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[1]")
		# @selenium.click(:id, 'spreOK_btn-btnIconEl')
		# @selenium.verify_text_from_element(:id, 'exp1_btn4_lbl', "Hand Free Auto Answer");
		
		# #@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item3"				
		# @selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'exp1_btn5')		
		# @selenium.verify_text_from_element(:id, 'exp1_btn5_lbl', "SPRE");
		# @selenium.double_click(:id, "exp1_btn5_lbl")
		# @selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[1]")
		# @selenium.click(:id, 'spreOK_btn-btnIconEl')
		# @selenium.verify_text_from_element(:id, 'exp1_btn5_lbl', "Hand Free Auto Answer");
		
		# #@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item3"				
		# @selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'exp1_btn6')		
		# @selenium.verify_text_from_element(:id, 'exp1_btn6_lbl', "SPRE");
		# @selenium.double_click(:id, "exp1_btn6_lbl")
		# @selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[1]")
		# @selenium.click(:id, 'spreOK_btn-btnIconEl')
		# @selenium.verify_text_from_element(:id, 'exp1_btn6_lbl', "Hand Free Auto Answer");
		
		# #@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item3"				
		# @selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'exp1_btn7')		
		# @selenium.verify_text_from_element(:id, 'exp1_btn7_lbl', "SPRE");
		# @selenium.double_click(:id, "exp1_btn7_lbl")
		# @selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[1]")
		# @selenium.click(:id, 'spreOK_btn-btnIconEl')
		# @selenium.verify_text_from_element(:id, 'exp1_btn7_lbl', "Hand Free Auto Answer");
		
		# #@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item3"				
		# @selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'exp1_btn8')		
		# @selenium.verify_text_from_element(:id, 'exp1_btn8_lbl', "SPRE");
		# @selenium.double_click(:id, "exp1_btn8_lbl")
		# @selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[1]")
		# @selenium.click(:id, 'spreOK_btn-btnIconEl')
		# @selenium.verify_text_from_element(:id, 'exp1_btn8_lbl', "Hand Free Auto Answer");
		
		# #@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item3"				
		# @selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'exp1_btn9')		
		# @selenium.verify_text_from_element(:id, 'exp1_btn9_lbl', "SPRE");
		# @selenium.double_click(:id, "exp1_btn9_lbl")
		# @selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[1]")
		# @selenium.click(:id, 'spreOK_btn-btnIconEl')
		# @selenium.verify_text_from_element(:id, 'exp1_btn9_lbl', "Hand Free Auto Answer");
		
		# #@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item3"				
		# @selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'exp1_btn10')		
		# @selenium.verify_text_from_element(:id, 'exp1_btn10_lbl', "SPRE");
		# @selenium.double_click(:id, "exp1_btn10_lbl")
		# @selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[1]")
		# @selenium.click(:id, 'spreOK_btn-btnIconEl')
		# @selenium.verify_text_from_element(:id, 'exp1_btn10_lbl', "Hand Free Auto Answer");
		
		# #@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item3"				
		# @selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'exp1_btn11')		
		# @selenium.verify_text_from_element(:id, 'exp1_btn11_lbl', "SPRE");
		# @selenium.double_click(:id, "exp1_btn11_lbl")
		# @selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[1]")
		# @selenium.click(:id, 'spreOK_btn-btnIconEl')
		# @selenium.verify_text_from_element(:id, 'exp1_btn11_lbl', "Hand Free Auto Answer");
		
		# #@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item3"				
		# @selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'exp1_btn12')		
		# @selenium.verify_text_from_element(:id, 'exp1_btn12_lbl', "SPRE");
		# @selenium.double_click(:id, "exp1_btn12_lbl")
		# @selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[1]")
		# @selenium.click(:id, 'spreOK_btn-btnIconEl')
		# @selenium.verify_text_from_element(:id, 'exp1_btn12_lbl', "Hand Free Auto Answer");
		
		# #@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item3"				
		# @selenium.drag_and_drop(:id, 'phoneFunc0_3', :id, 'exp1_btn13')		
		# @selenium.verify_text_from_element(:id, 'exp1_btn13_lbl', "SPRE");
		# @selenium.double_click(:id, "exp1_btn13_lbl")
		# @selenium.click(:xpath, "//div[@id='spreSetting_grid']/div[2]/div/table/tbody/tr[1]")
		# @selenium.click(:id, 'spreOK_btn-btnIconEl')
		# @selenium.verify_text_from_element(:id, 'exp1_btn13_lbl', "Hand Free Auto Answer");
		
		# #@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 14"
		# #@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 13"
		# #@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 12"
		# #@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 11"
		# #@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 10"
		# #@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 9"
		# #@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 8"
		# #@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 7"
		# #@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 6"
		# #@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 5"
		# #@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 5"
		# #@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 4"
		# #@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 3"
		# #@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 2"
		# #@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 1"
		# @selenium.click_by_script('exp1_btn13_del-innerCt')
		# @selenium.verify_text_from_element(:id, 'exp1_btn13_lbl', "");
		# @selenium.click_by_script('exp1_btn12_del-innerCt')
		# @selenium.verify_text_from_element(:id, 'exp1_btn12_lbl', "");		
		# @selenium.click_by_script('exp1_btn11_del-innerCt')
		# @selenium.verify_text_from_element(:id, 'exp1_btn11_lbl', "");			
		# @selenium.click_by_script('exp1_btn10_del-innerCt')
		# @selenium.verify_text_from_element(:id, 'exp1_btn10_lbl', "");	
		# @selenium.click_by_script('exp1_btn9_del-innerCt')
		# @selenium.verify_text_from_element(:id, 'exp1_btn9_lbl', "");	
		# @selenium.click_by_script('exp1_btn8_del-innerCt')
		# @selenium.verify_text_from_element(:id, 'exp1_btn8_lbl', "");
		# @selenium.click_by_script('exp1_btn7_del-innerCt')
		# @selenium.verify_text_from_element(:id, 'exp1_btn7_lbl', "");
		# @selenium.click_by_script('exp1_btn6_del-innerCt')
		# @selenium.verify_text_from_element(:id, 'exp1_btn6_lbl', "");
		# @selenium.click_by_script('exp1_btn5_del-innerCt')
		# @selenium.verify_text_from_element(:id, 'exp1_btn5_lbl', "");			
		# @selenium.click_by_script('exp1_btn4_del-innerCt')
		# @selenium.verify_text_from_element(:id, 'exp1_btn4_lbl', "");	
		# @selenium.click_by_script('exp1_btn3_del-innerCt')
		# @selenium.verify_text_from_element(:id, 'exp1_btn3_lbl', "");	
		# @selenium.click_by_script('exp1_btn2_del-innerCt')
		# @selenium.verify_text_from_element(:id, 'exp1_btn2_lbl', "");
		# @selenium.click_by_script('exp1_btn1_del-innerCt')
		# @selenium.verify_text_from_element(:id, 'exp1_btn1_lbl', "");
		# @selenium.click_by_script('exp1_btn0_del-innerCt')
		# @selenium.verify_text_from_element(:id, 'exp1_btn0_lbl', "");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_4', :id, 'exp1_btn0')		
		@selenium.verify_text_from_element(:id, 'exp1_btn0_lbl', "System Schedule");
		@selenium.double_click(:id, "exp1_btn0_lbl")
		@selenium.click_text_from_combobox(:id, 'systemschedule_combobox-inputEl', "Default")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_4', :id, 'exp1_btn1')		
		@selenium.verify_text_from_element(:id, 'exp1_btn1_lbl', "System Schedule");
		@selenium.double_click(:id, "exp1_btn1_lbl")
		@selenium.click_text_from_combobox(:id, 'systemschedule_combobox-inputEl', "Night")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_4', :id, 'exp1_btn2')		
		@selenium.verify_text_from_element(:id, 'exp1_btn2_lbl', "System Schedule");
		@selenium.double_click(:id, "exp1_btn2_lbl")
		@selenium.click_text_from_combobox(:id, 'systemschedule_combobox-inputEl', "Lunch")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_4', :id, 'exp1_btn3')		
		@selenium.verify_text_from_element(:id, 'exp1_btn3_lbl', "System Schedule");
		@selenium.double_click(:id, "exp1_btn3_lbl")
		@selenium.click_text_from_combobox(:id, 'systemschedule_combobox-inputEl', "Weekend")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_4', :id, 'exp1_btn4')		
		@selenium.verify_text_from_element(:id, 'exp1_btn4_lbl', "System Schedule");
		@selenium.double_click(:id, "exp1_btn4_lbl")
		@selenium.click_text_from_combobox(:id, 'systemschedule_combobox-inputEl', "Override")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_4', :id, 'exp1_btn5')		
		@selenium.verify_text_from_element(:id, 'exp1_btn5_lbl', "System Schedule");
		@selenium.double_click(:id, "exp1_btn5_lbl")
		@selenium.click_text_from_combobox(:id, 'systemschedule_combobox-inputEl', "Custom1")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_4', :id, 'exp1_btn6')		
		@selenium.verify_text_from_element(:id, 'exp1_btn6_lbl', "System Schedule");
		@selenium.double_click(:id, "exp1_btn6_lbl")
		@selenium.click_text_from_combobox(:id, 'systemschedule_combobox-inputEl', "Custom2")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_4', :id, 'exp1_btn7')		
		@selenium.verify_text_from_element(:id, 'exp1_btn7_lbl', "System Schedule");
		@selenium.double_click(:id, "exp1_btn7_lbl")
		@selenium.click_text_from_combobox(:id, 'systemschedule_combobox-inputEl', "Custom3")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_4', :id, 'exp1_btn8')		
		@selenium.verify_text_from_element(:id, 'exp1_btn8_lbl', "System Schedule");
		@selenium.double_click(:id, "exp1_btn8_lbl")
		@selenium.click_text_from_combobox(:id, 'systemschedule_combobox-inputEl', "Default")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_4', :id, 'exp1_btn9')		
		@selenium.verify_text_from_element(:id, 'exp1_btn9_lbl', "System Schedule");
		@selenium.double_click(:id, "exp1_btn9_lbl")
		@selenium.click_text_from_combobox(:id, 'systemschedule_combobox-inputEl', "Night")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_4', :id, 'exp1_btn10')		
		@selenium.verify_text_from_element(:id, 'exp1_btn10_lbl', "System Schedule");
		@selenium.double_click(:id, "exp1_btn10_lbl")
		@selenium.click_text_from_combobox(:id, 'systemschedule_combobox-inputEl', "Lunch")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_4', :id, 'exp1_btn11')		
		@selenium.verify_text_from_element(:id, 'exp1_btn11_lbl', "System Schedule");
		@selenium.double_click(:id, "exp1_btn11_lbl")
		@selenium.click_text_from_combobox(:id, 'systemschedule_combobox-inputEl', "Weekend")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_4', :id, 'exp1_btn12')		
		@selenium.verify_text_from_element(:id, 'exp1_btn12_lbl', "System Schedule");
		@selenium.double_click(:id, "exp1_btn12_lbl")
		@selenium.click_text_from_combobox(:id, 'systemschedule_combobox-inputEl', "Override")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_4', :id, 'exp1_btn13')		
		@selenium.verify_text_from_element(:id, 'exp1_btn13_lbl', "System Schedule");
		@selenium.double_click(:id, "exp1_btn13_lbl")
		@selenium.click_text_from_combobox(:id, 'systemschedule_combobox-inputEl', "Custom1")
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 14"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 13"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 12"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 11"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 10"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 9"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 8"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 7"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 6"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 5"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 4"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 3"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 2"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 1"
		@selenium.click_by_script('exp1_btn13_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn13_lbl', "");
		@selenium.click_by_script('exp1_btn12_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn12_lbl', "");		
		@selenium.click_by_script('exp1_btn11_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn11_lbl', "");			
		@selenium.click_by_script('exp1_btn10_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn10_lbl', "");	
		@selenium.click_by_script('exp1_btn9_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn9_lbl', "");	
		@selenium.click_by_script('exp1_btn8_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn8_lbl', "");
		@selenium.click_by_script('exp1_btn7_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn7_lbl', "");
		@selenium.click_by_script('exp1_btn6_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn6_lbl', "");
		@selenium.click_by_script('exp1_btn5_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn5_lbl', "");			
		@selenium.click_by_script('exp1_btn4_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn4_lbl', "");	
		@selenium.click_by_script('exp1_btn3_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn3_lbl', "");	
		@selenium.click_by_script('exp1_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn2_lbl', "");
		@selenium.click_by_script('exp1_btn1_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn1_lbl', "");
		@selenium.click_by_script('exp1_btn0_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn0_lbl', "");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_5', :id, 'exp1_btn0')		
		@selenium.verify_text_from_element(:id, 'exp1_btn0_lbl', "User");
		@selenium.double_click(:id, "exp1_btn0_lbl")
		@selenium.click_text_from_combobox(:id, 'user_combobox-inputEl', "Andre Benoit Cell")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_5', :id, 'exp1_btn1')		
		@selenium.verify_text_from_element(:id, 'exp1_btn1_lbl', "User");
		@selenium.double_click(:id, "exp1_btn1_lbl")
		@selenium.click_text_from_combobox(:id, 'user_combobox-inputEl', "Andre Benoit Home")

		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_5', :id, 'exp1_btn2')		
		@selenium.verify_text_from_element(:id, 'exp1_btn2_lbl', "User");
		@selenium.double_click(:id, "exp1_btn2_lbl")
		@selenium.click_text_from_combobox(:id, 'user_combobox-inputEl', "Andre Benoit EXT")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_5', :id, 'exp1_btn3')		
		@selenium.verify_text_from_element(:id, 'exp1_btn3_lbl', "User");
		@selenium.double_click(:id, "exp1_btn3_lbl")
		@selenium.click_text_from_combobox(:id, 'user_combobox-inputEl', "Ben Bishop Cell")

		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_5', :id, 'exp1_btn4')		
		@selenium.verify_text_from_element(:id, 'exp1_btn4_lbl', "User");
		@selenium.double_click(:id, "exp1_btn4_lbl")
		@selenium.click_text_from_combobox(:id, 'user_combobox-inputEl', "Ben Bishop Home")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_5', :id, 'exp1_btn5')		
		@selenium.verify_text_from_element(:id, 'exp1_btn5_lbl', "User");
		@selenium.double_click(:id, "exp1_btn5_lbl")
		@selenium.click_text_from_combobox(:id, 'user_combobox-inputEl', "Ben Bishop EXT")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_5', :id, 'exp1_btn6')		
		@selenium.verify_text_from_element(:id, 'exp1_btn6_lbl', "User");
		@selenium.double_click(:id, "exp1_btn6_lbl")
		@selenium.click_text_from_combobox(:id, 'user_combobox-inputEl', "Chris Neil Cell")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_5', :id, 'exp1_btn7')		
		@selenium.verify_text_from_element(:id, 'exp1_btn7_lbl', "User");
		@selenium.double_click(:id, "exp1_btn7_lbl")
		@selenium.click_text_from_combobox(:id, 'user_combobox-inputEl', "Chris Neil Home")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_5', :id, 'exp1_btn8')		
		@selenium.verify_text_from_element(:id, 'exp1_btn8_lbl', "User");
		@selenium.double_click(:id, "exp1_btn8_lbl")
		@selenium.click_text_from_combobox(:id, 'user_combobox-inputEl', "Chris Neil EXT")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_5', :id, 'exp1_btn9')		
		@selenium.verify_text_from_element(:id, 'exp1_btn9_lbl', "User");
		@selenium.double_click(:id, "exp1_btn9_lbl")
		@selenium.click_text_from_combobox(:id, 'user_combobox-inputEl', "Chris Phillips Cell")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_5', :id, 'exp1_btn10')		
		@selenium.verify_text_from_element(:id, 'exp1_btn10_lbl', "User");
		@selenium.double_click(:id, "exp1_btn10_lbl")
		@selenium.click_text_from_combobox(:id, 'user_combobox-inputEl', "Chris Phillips Home")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_5', :id, 'exp1_btn11')		
		@selenium.verify_text_from_element(:id, 'exp1_btn11_lbl', "User");
		@selenium.double_click(:id, "exp1_btn11_lbl")
		@selenium.click_text_from_combobox(:id, 'user_combobox-inputEl', "Chris Phillips EXT")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_5', :id, 'exp1_btn12')		
		@selenium.verify_text_from_element(:id, 'exp1_btn12_lbl', "User");
		@selenium.double_click(:id, "exp1_btn12_lbl")
		@selenium.click_text_from_combobox(:id, 'user_combobox-inputEl', "Colin Greening Cell")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_5', :id, 'exp1_btn13')		
		@selenium.verify_text_from_element(:id, 'exp1_btn13_lbl', "User");
		@selenium.double_click(:id, "exp1_btn13_lbl")
		@selenium.click_text_from_combobox(:id, 'user_combobox-inputEl', "Colin Greening Home")
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 14"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 13"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 12"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 11"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 10"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 9"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 8"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 7"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 6"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 5"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 4"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 3"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 2"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 1"
		@selenium.click_by_script('exp1_btn13_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn13_lbl', "");
		@selenium.click_by_script('exp1_btn12_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn12_lbl', "");		
		@selenium.click_by_script('exp1_btn11_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn11_lbl', "");			
		@selenium.click_by_script('exp1_btn10_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn10_lbl', "");	
		@selenium.click_by_script('exp1_btn9_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn9_lbl', "");	
		@selenium.click_by_script('exp1_btn8_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn8_lbl', "");
		@selenium.click_by_script('exp1_btn7_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn7_lbl', "");
		@selenium.click_by_script('exp1_btn6_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn6_lbl', "");
		@selenium.click_by_script('exp1_btn5_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn5_lbl', "");			
		@selenium.click_by_script('exp1_btn4_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn4_lbl', "");	
		@selenium.click_by_script('exp1_btn3_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn3_lbl', "");	
		@selenium.click_by_script('exp1_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn2_lbl', "");
		@selenium.click_by_script('exp1_btn1_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn1_lbl', "");
		@selenium.click_by_script('exp1_btn0_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn0_lbl', "");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_6', :id, 'exp1_btn0')		
		@selenium.verify_text_from_element(:id, 'exp1_btn0_lbl', "Mailbox");
		@selenium.double_click(:id, "exp1_btn0_lbl")
		@selenium.click_text_from_combobox(:id, 'mailbox_combobox-inputEl', "Andre Benoit")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_6', :id, 'exp1_btn1')		
		@selenium.verify_text_from_element(:id, 'exp1_btn1_lbl', "Mailbox");
		@selenium.double_click(:id, "exp1_btn1_lbl")
		@selenium.click_text_from_combobox(:id, 'mailbox_combobox-inputEl', "Ben Bishop")

		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_6', :id, 'exp1_btn2')		
		@selenium.verify_text_from_element(:id, 'exp1_btn2_lbl', "Mailbox");
		@selenium.double_click(:id, "exp1_btn2_lbl")
		@selenium.click_text_from_combobox(:id, 'mailbox_combobox-inputEl', "Chris Neil")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_6', :id, 'exp1_btn3')		
		@selenium.verify_text_from_element(:id, 'exp1_btn3_lbl', "Mailbox");
		@selenium.double_click(:id, "exp1_btn3_lbl")
		@selenium.click_text_from_combobox(:id, 'mailbox_combobox-inputEl', "Chris Phillips")

		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_6', :id, 'exp1_btn4')		
		@selenium.verify_text_from_element(:id, 'exp1_btn4_lbl', "Mailbox");
		@selenium.double_click(:id, "exp1_btn4_lbl")
		@selenium.click_text_from_combobox(:id, 'mailbox_combobox-inputEl', "Colin Greening")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_6', :id, 'exp1_btn5')		
		@selenium.verify_text_from_element(:id, 'exp1_btn5_lbl', "Mailbox");
		@selenium.double_click(:id, "exp1_btn5_lbl")
		@selenium.click_text_from_combobox(:id, 'mailbox_combobox-inputEl', "Craig Anderson")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_6', :id, 'exp1_btn6')		
		@selenium.verify_text_from_element(:id, 'exp1_btn6_lbl', "Mailbox");
		@selenium.double_click(:id, "exp1_btn6_lbl")
		@selenium.click_text_from_combobox(:id, 'mailbox_combobox-inputEl', "Daniel Alfredsson")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_6', :id, 'exp1_btn7')		
		@selenium.verify_text_from_element(:id, 'exp1_btn7_lbl', "Mailbox");
		@selenium.double_click(:id, "exp1_btn7_lbl")
		@selenium.click_text_from_combobox(:id, 'mailbox_combobox-inputEl', "David Dziurzynski")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_6', :id, 'exp1_btn8')		
		@selenium.verify_text_from_element(:id, 'exp1_btn8_lbl', "Mailbox");
		@selenium.double_click(:id, "exp1_btn8_lbl")
		@selenium.click_text_from_combobox(:id, 'mailbox_combobox-inputEl', "Derek Grant")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_6', :id, 'exp1_btn9')		
		@selenium.verify_text_from_element(:id, 'exp1_btn9_lbl', "Mailbox");
		@selenium.double_click(:id, "exp1_btn9_lbl")
		@selenium.click_text_from_combobox(:id, 'mailbox_combobox-inputEl', "Eric Gryba")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_6', :id, 'exp1_btn10')		
		@selenium.verify_text_from_element(:id, 'exp1_btn10_lbl', "Mailbox");
		@selenium.double_click(:id, "exp1_btn10_lbl")
		@selenium.click_text_from_combobox(:id, 'mailbox_combobox-inputEl', "Erik Condra")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_6', :id, 'exp1_btn11')		
		@selenium.verify_text_from_element(:id, 'exp1_btn11_lbl', "Mailbox");
		@selenium.double_click(:id, "exp1_btn11_lbl")
		@selenium.click_text_from_combobox(:id, 'mailbox_combobox-inputEl', "Erik Karlsson")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_6', :id, 'exp1_btn12')		
		@selenium.verify_text_from_element(:id, 'exp1_btn12_lbl', "Mailbox");
		@selenium.double_click(:id, "exp1_btn12_lbl")
		@selenium.click_text_from_combobox(:id, 'mailbox_combobox-inputEl', "Guillaume Latendresse")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_6', :id, 'exp1_btn13')		
		@selenium.verify_text_from_element(:id, 'exp1_btn13_lbl', "Mailbox");
		@selenium.double_click(:id, "exp1_btn13_lbl")
		@selenium.click_text_from_combobox(:id, 'mailbox_combobox-inputEl', "Jakob Silfverberg")		
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 14"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 13"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 12"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 11"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 10"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 9"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 8"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 7"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 6"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 5"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 4"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 3"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 2"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 1"
		@selenium.click_by_script('exp1_btn13_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn13_lbl', "");
		@selenium.click_by_script('exp1_btn12_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn12_lbl', "");		
		@selenium.click_by_script('exp1_btn11_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn11_lbl', "");			
		@selenium.click_by_script('exp1_btn10_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn10_lbl', "");	
		@selenium.click_by_script('exp1_btn9_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn9_lbl', "");	
		@selenium.click_by_script('exp1_btn8_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn8_lbl', "");
		@selenium.click_by_script('exp1_btn7_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn7_lbl', "");
		@selenium.click_by_script('exp1_btn6_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn6_lbl', "");
		@selenium.click_by_script('exp1_btn5_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn5_lbl', "");			
		@selenium.click_by_script('exp1_btn4_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn4_lbl', "");	
		@selenium.click_by_script('exp1_btn3_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn3_lbl', "");	
		@selenium.click_by_script('exp1_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn2_lbl', "");
		@selenium.click_by_script('exp1_btn1_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn1_lbl', "");
		@selenium.click_by_script('exp1_btn0_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn0_lbl', "");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_7', :id, 'exp1_btn0')		
		@selenium.verify_text_from_element(:id, 'exp1_btn0_lbl', "Speed Dial");
		@selenium.double_click(:id, "exp1_btn0_lbl")
		@selenium.click_text_from_combobox(:id, 'speeddial_combobox-inputEl', "Bistro Lunchette  Home")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_7', :id, 'exp1_btn1')		
		@selenium.verify_text_from_element(:id, 'exp1_btn1_lbl', "Speed Dial");
		@selenium.double_click(:id, "exp1_btn1_lbl")
		@selenium.click_text_from_combobox(:id, 'speeddial_combobox-inputEl', "Chris Schwarz Cell")	

		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_7', :id, 'exp1_btn2')		
		@selenium.verify_text_from_element(:id, 'exp1_btn2_lbl', "Speed Dial");
		@selenium.double_click(:id, "exp1_btn2_lbl")
		@selenium.click_text_from_combobox(:id, 'speeddial_combobox-inputEl', "Chris Schwarz Home")	
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_7', :id, 'exp1_btn3')		
		@selenium.verify_text_from_element(:id, 'exp1_btn3_lbl', "Speed Dial");
		@selenium.double_click(:id, "exp1_btn3_lbl")
		@selenium.click_text_from_combobox(:id, 'speeddial_combobox-inputEl', "Chris Schwarz EXT")	

		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_7', :id, 'exp1_btn4')		
		@selenium.verify_text_from_element(:id, 'exp1_btn4_lbl', "Speed Dial");
		@selenium.double_click(:id, "exp1_btn4_lbl")
		@selenium.click_text_from_combobox(:id, 'speeddial_combobox-inputEl', "Daniel Alfredsson Cell")	
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_7', :id, 'exp1_btn5')		
		@selenium.verify_text_from_element(:id, 'exp1_btn5_lbl', "Speed Dial");
		@selenium.double_click(:id, "exp1_btn5_lbl")
		@selenium.click_text_from_combobox(:id, 'speeddial_combobox-inputEl', "Daniel Alfredsson Home")	
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_7', :id, 'exp1_btn6')		
		@selenium.verify_text_from_element(:id, 'exp1_btn6_lbl', "Speed Dial");
		@selenium.double_click(:id, "exp1_btn6_lbl")
		@selenium.click_text_from_combobox(:id, 'speeddial_combobox-inputEl', "Daniel Alfredsson EXT")	
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_7', :id, 'exp1_btn7')		
		@selenium.verify_text_from_element(:id, 'exp1_btn7_lbl', "Speed Dial");
		@selenium.double_click(:id, "exp1_btn7_lbl")
		@selenium.click_text_from_combobox(:id, 'speeddial_combobox-inputEl', "Derek Grant Cell")	
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_7', :id, 'exp1_btn8')		
		@selenium.verify_text_from_element(:id, 'exp1_btn8_lbl', "Speed Dial");
		@selenium.double_click(:id, "exp1_btn8_lbl")
		@selenium.click_text_from_combobox(:id, 'speeddial_combobox-inputEl', "Derek Grant Home")	
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_7', :id, 'exp1_btn9')		
		@selenium.verify_text_from_element(:id, 'exp1_btn9_lbl', "Speed Dial");
		@selenium.double_click(:id, "exp1_btn9_lbl")
		@selenium.click_text_from_combobox(:id, 'speeddial_combobox-inputEl', "Derek Grant EXT")	
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_7', :id, 'exp1_btn10')		
		@selenium.verify_text_from_element(:id, 'exp1_btn10_lbl', "Speed Dial");
		@selenium.double_click(:id, "exp1_btn10_lbl")
		@selenium.click_text_from_combobox(:id, 'speeddial_combobox-inputEl', "Eric Gryba Cell")	
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_7', :id, 'exp1_btn11')		
		@selenium.verify_text_from_element(:id, 'exp1_btn11_lbl', "Speed Dial");
		@selenium.double_click(:id, "exp1_btn11_lbl")
		@selenium.click_text_from_combobox(:id, 'speeddial_combobox-inputEl', "Eric Gryba Home")	
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_7', :id, 'exp1_btn12')		
		@selenium.verify_text_from_element(:id, 'exp1_btn12_lbl', "Speed Dial");
		@selenium.double_click(:id, "exp1_btn12_lbl")
		@selenium.click_text_from_combobox(:id, 'speeddial_combobox-inputEl', "Eric Gryba EXT")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_7', :id, 'exp1_btn13')		
		@selenium.verify_text_from_element(:id, 'exp1_btn13_lbl', "Speed Dial");
		@selenium.double_click(:id, "exp1_btn13_lbl")
		@selenium.click_text_from_combobox(:id, 'speeddial_combobox-inputEl', "Jannet	 Doe Home")	
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 14"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 13"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 12"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 11"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 10"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 9"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 8"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 7"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 6"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 5"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 4"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 3"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 2"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 1"
		@selenium.click_by_script('exp1_btn13_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn13_lbl', "");
		@selenium.click_by_script('exp1_btn12_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn12_lbl', "");		
		@selenium.click_by_script('exp1_btn11_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn11_lbl', "");			
		@selenium.click_by_script('exp1_btn10_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn10_lbl', "");	
		@selenium.click_by_script('exp1_btn9_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn9_lbl', "");	
		@selenium.click_by_script('exp1_btn8_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn8_lbl', "");
		@selenium.click_by_script('exp1_btn7_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn7_lbl', "");
		@selenium.click_by_script('exp1_btn6_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn6_lbl', "");
		@selenium.click_by_script('exp1_btn5_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn5_lbl', "");			
		@selenium.click_by_script('exp1_btn4_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn4_lbl', "");	
		@selenium.click_by_script('exp1_btn3_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn3_lbl', "");	
		@selenium.click_by_script('exp1_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn2_lbl', "");
		@selenium.click_by_script('exp1_btn1_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn1_lbl', "");
		@selenium.click_by_script('exp1_btn0_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn0_lbl', "");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_8', :id, 'exp1_btn0')		
		@selenium.verify_text_from_element(:id, 'exp1_btn0_lbl', "Park Zone");
		@selenium.double_click(:id, "exp1_btn0_lbl")
		@selenium.click_text_from_combobox(:id, 'parkzone_combobox-inputEl', "1")	
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_8', :id, 'exp1_btn1')		
		@selenium.verify_text_from_element(:id, 'exp1_btn1_lbl', "Park Zone");
		@selenium.double_click(:id, "exp1_btn1_lbl")
		@selenium.click_text_from_combobox(:id, 'parkzone_combobox-inputEl', "2")	

		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_8', :id, 'exp1_btn2')		
		@selenium.verify_text_from_element(:id, 'exp1_btn2_lbl', "Park Zone");
		@selenium.double_click(:id, "exp1_btn2_lbl")
		@selenium.click_text_from_combobox(:id, 'parkzone_combobox-inputEl', "3")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_8', :id, 'exp1_btn3')		
		@selenium.verify_text_from_element(:id, 'exp1_btn3_lbl', "Park Zone");
		@selenium.double_click(:id, "exp1_btn3_lbl")
		@selenium.click_text_from_combobox(:id, 'parkzone_combobox-inputEl', "1")	

		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_8', :id, 'exp1_btn4')		
		@selenium.verify_text_from_element(:id, 'exp1_btn4_lbl', "Park Zone");
		@selenium.double_click(:id, "exp1_btn4_lbl")
		@selenium.click_text_from_combobox(:id, 'parkzone_combobox-inputEl', "2")	
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_8', :id, 'exp1_btn5')		
		@selenium.verify_text_from_element(:id, 'exp1_btn5_lbl', "Park Zone");
		@selenium.double_click(:id, "exp1_btn5_lbl")
		@selenium.click_text_from_combobox(:id, 'parkzone_combobox-inputEl', "3")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_8', :id, 'exp1_btn6')		
		@selenium.verify_text_from_element(:id, 'exp1_btn6_lbl', "Park Zone");
		@selenium.double_click(:id, "exp1_btn6_lbl")
		@selenium.click_text_from_combobox(:id, 'parkzone_combobox-inputEl', "1")	
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_8', :id, 'exp1_btn7')		
		@selenium.verify_text_from_element(:id, 'exp1_btn7_lbl', "Park Zone");
		@selenium.double_click(:id, "exp1_btn7_lbl")
		@selenium.click_text_from_combobox(:id, 'parkzone_combobox-inputEl', "2")	
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_8', :id, 'exp1_btn8')		
		@selenium.verify_text_from_element(:id, 'exp1_btn8_lbl', "Park Zone");
		@selenium.double_click(:id, "exp1_btn8_lbl")
		@selenium.click_text_from_combobox(:id, 'parkzone_combobox-inputEl', "3")	
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_8', :id, 'exp1_btn9')		
		@selenium.verify_text_from_element(:id, 'exp1_btn9_lbl', "Park Zone");
		@selenium.double_click(:id, "exp1_btn9_lbl")
		@selenium.click_text_from_combobox(:id, 'parkzone_combobox-inputEl', "1")	
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_8', :id, 'exp1_btn10')		
		@selenium.verify_text_from_element(:id, 'exp1_btn10_lbl', "Park Zone");
		@selenium.double_click(:id, "exp1_btn10_lbl")
		@selenium.click_text_from_combobox(:id, 'parkzone_combobox-inputEl', "2")	
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_8', :id, 'exp1_btn11')		
		@selenium.verify_text_from_element(:id, 'exp1_btn11_lbl', "Park Zone");
		@selenium.double_click(:id, "exp1_btn11_lbl")
		@selenium.click_text_from_combobox(:id, 'parkzone_combobox-inputEl', "3")	
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_8', :id, 'exp1_btn12')		
		@selenium.verify_text_from_element(:id, 'exp1_btn12_lbl', "Park Zone");
		@selenium.double_click(:id, "exp1_btn12_lbl")
		@selenium.click_text_from_combobox(:id, 'parkzone_combobox-inputEl', "1")	
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_8', :id, 'exp1_btn13')		
		@selenium.verify_text_from_element(:id, 'exp1_btn13_lbl', "Park Zone");
		@selenium.double_click(:id, "exp1_btn13_lbl")
		@selenium.click_text_from_combobox(:id, 'parkzone_combobox-inputEl', "2")	
		
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 14"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 13"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 12"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 11"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 10"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 9"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 8"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 7"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 6"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 5"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 4"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 3"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 2"
		#@selenium.testheader "PPM-Setting (Phone-MAIN) Menu Items (Delete) Button 1"
		@selenium.click_by_script('exp1_btn13_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn13_lbl', "");
		@selenium.click_by_script('exp1_btn12_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn12_lbl', "");		
		@selenium.click_by_script('exp1_btn11_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn11_lbl', "");			
		@selenium.click_by_script('exp1_btn10_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn10_lbl', "");	
		@selenium.click_by_script('exp1_btn9_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn9_lbl', "");	
		@selenium.click_by_script('exp1_btn8_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn8_lbl', "");
		@selenium.click_by_script('exp1_btn7_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn7_lbl', "");
		@selenium.click_by_script('exp1_btn6_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn6_lbl', "");
		@selenium.click_by_script('exp1_btn5_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn5_lbl', "");			
		@selenium.click_by_script('exp1_btn4_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn4_lbl', "");	
		@selenium.click_by_script('exp1_btn3_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn3_lbl', "");	
		@selenium.click_by_script('exp1_btn2_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn2_lbl', "");
		@selenium.click_by_script('exp1_btn1_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn1_lbl', "");
		@selenium.click_by_script('exp1_btn0_del-innerCt')
		@selenium.verify_text_from_element(:id, 'exp1_btn0_lbl', "");
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_9', :id, 'exp1_btn0')		
		@selenium.verify_text_from_element(:id, 'exp1_btn0_lbl', "Paging Group");
		@selenium.double_click(:id, "exp1_btn0_lbl")
		@selenium.click_text_from_combobox(:id, 'paginggroup_combobox-inputEl', "3721")	
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_9', :id, 'exp1_btn1')		
		@selenium.verify_text_from_element(:id, 'exp1_btn1_lbl', "Paging Group");
		@selenium.double_click(:id, "exp1_btn1_lbl")
		@selenium.click_text_from_combobox(:id, 'paginggroup_combobox-inputEl', "3309")

		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_9', :id, 'exp1_btn2')		
		@selenium.verify_text_from_element(:id, 'exp1_btn2_lbl', "Paging Group");
		@selenium.double_click(:id, "exp1_btn2_lbl")
		@selenium.click_text_from_combobox(:id, 'paginggroup_combobox-inputEl', "7030")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_9', :id, 'exp1_btn3')		
		@selenium.verify_text_from_element(:id, 'exp1_btn3_lbl', "Paging Group");
		@selenium.double_click(:id, "exp1_btn3_lbl")
		@selenium.click_text_from_combobox(:id, 'paginggroup_combobox-inputEl', "3721")

		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_9', :id, 'exp1_btn4')		
		@selenium.verify_text_from_element(:id, 'exp1_btn4_lbl', "Paging Group");
		@selenium.double_click(:id, "exp1_btn4_lbl")
		@selenium.click_text_from_combobox(:id, 'paginggroup_combobox-inputEl', "3309")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_9', :id, 'exp1_btn5')		
		@selenium.verify_text_from_element(:id, 'exp1_btn5_lbl', "Paging Group");
		@selenium.double_click(:id, "exp1_btn5_lbl")
		@selenium.click_text_from_combobox(:id, 'paginggroup_combobox-inputEl', "7030")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_9', :id, 'exp1_btn6')		
		@selenium.verify_text_from_element(:id, 'exp1_btn6_lbl', "Paging Group");
		@selenium.double_click(:id, "exp1_btn6_lbl")
		@selenium.click_text_from_combobox(:id, 'paginggroup_combobox-inputEl', "3721")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_9', :id, 'exp1_btn7')		
		@selenium.verify_text_from_element(:id, 'exp1_btn7_lbl', "Paging Group");
		@selenium.double_click(:id, "exp1_btn7_lbl")
		@selenium.click_text_from_combobox(:id, 'paginggroup_combobox-inputEl', "3309")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_9', :id, 'exp1_btn8')		
		@selenium.verify_text_from_element(:id, 'exp1_btn8_lbl', "Paging Group");
		@selenium.double_click(:id, "exp1_btn8_lbl")
		@selenium.click_text_from_combobox(:id, 'paginggroup_combobox-inputEl', "7030")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_9', :id, 'exp1_btn9')		
		@selenium.verify_text_from_element(:id, 'exp1_btn9_lbl', "Paging Group");
		@selenium.double_click(:id, "exp1_btn9_lbl")
		@selenium.click_text_from_combobox(:id, 'paginggroup_combobox-inputEl', "7030")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_9', :id, 'exp1_btn10')		
		@selenium.verify_text_from_element(:id, 'exp1_btn10_lbl', "Paging Group");
		@selenium.double_click(:id, "exp1_btn10_lbl")
		@selenium.click_text_from_combobox(:id, 'paginggroup_combobox-inputEl', "3721")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_9', :id, 'exp1_btn11')		
		@selenium.verify_text_from_element(:id, 'exp1_btn11_lbl', "Paging Group");
		@selenium.double_click(:id, "exp1_btn11_lbl")
		@selenium.click_text_from_combobox(:id, 'paginggroup_combobox-inputEl', "3309")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_9', :id, 'exp1_btn12')		
		@selenium.verify_text_from_element(:id, 'exp1_btn12_lbl', "Paging Group");
		@selenium.double_click(:id, "exp1_btn12_lbl")
		@selenium.click_text_from_combobox(:id, 'paginggroup_combobox-inputEl', "7030")
		
		#@selenium.testheader "PPM-Setting (Phone-EXPANSION1) Menu Items (Droppable) Item4"		
		@selenium.drag_and_drop(:id, 'phoneFunc0_9', :id, 'exp1_btn13')		
		@selenium.verify_text_from_element(:id, 'exp1_btn13_lbl', "Paging Group");
		@selenium.double_click(:id, "exp1_btn13_lbl")
		@selenium.click_text_from_combobox(:id, 'paginggroup_combobox-inputEl', "3721")
	end
end