require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

describe "PPM - FMFM Additions", :local => true do
	it "should login to PPM and navigate to FMFM" do	
	# groups
	# all //*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[1]/div
	# all internal //*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[2]/div
	# all external //*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[3]/div
	# Add new //*[@id="fmfmgroupsview"]/table/tbody/tr[3]/td[1]/div

	# times 
	# default //*[@id="fmfmtimesview"]/table/tbody/tr[2]/td[1]/div
	# night //*[@id="fmfmtimesview"]/table/tbody/tr[2]/td[2]/div
	# lunch //*[@id="fmfmtimesview"]/table/tbody/tr[2]/td[3]/div
	# weekend //*[@id="fmfmtimesview"]/table/tbody/tr[3]/td[1]/div
	# override //*[@id="fmfmtimesview"]/table/tbody/tr[3]/td[2]/div
	# Custom1 //*[@id="fmfmtimesview"]/table/tbody/tr[3]/td[3]/div
	# Custom2 //*[@id="fmfmtimesview"]/table/tbody/tr[4]/td[1]/div
	# Custom3 //*[@id="fmfmtimesview"]/table/tbody/tr[4]/td[2]/div

	# Action Set
	# Desk & Cell //*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[1]/div
	# Go To Voicemail //*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[2]/div
	# Add new //*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[3]/div

	# Rules
	# For //*[@id="col-1-innerCt']/div/div[2]/div/table/tbody/tr/td[2]/div/div
	# Delete For //*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i
	# Within //*[@id="col-1-innerCt']/div/div[2]/div/table/tbody/tr/td[4]/div/div
	# Delete Within //*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i
	# Do //*[@id="col-1-innerCt']/div/div[2]/div/table/tbody/tr/td[6]/div/div
	# Do Delete //*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i

	# Default Rule
	# For //*[@id="defaultruleviewid"]/table/tbody/tr/td[2]/div
	# For Delete //*[@id="defaultruleviewid"]/table/tbody/tr/td[2]/div/i
	# Within //*[@id="defaultruleviewid"]/table/tbody/tr/td[4]/div
	# Within Delete //*[@id="defaultruleviewid"]/table/tbody/tr/td[4]/div/i
	# Do //*[@id="defaultruleviewid"]/table/tbody/tr/td[6]/div
	# Do Delete //*[@id="defaultruleviewid"]/table/tbody/tr/td[6]/div/i
	
		@selenium.navigate.to "http://10.10.9.129/Login/index.php"
		@selenium.wait_for_element_present(:id, "loginnameid-inputEl", 15)
		@selenium.type(:id, "loginnameid-inputEl", '3011')
		@selenium.type(:id, "loginpasswordid-inputEl", '1234')
		sleep 1
		@selenium.click(:id, "loginbuttonid-btnIconEl")
		
		@selenium.click(:id, 'settings')
		@selenium.click(:xpath, '//div[@id="settingPanel"]/div/div/div[2]/div/a[5]')
		@selenium.click(:xpath, '//*[@id="cbPanel_grid-body"]/div/table/tbody/tr[5]')
		@selenium.click(:id, 'cbEdit-btnEl')
		sleep 5
	end
		
		it "should drag and drop Config Menu Items Combo 1"
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[2]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Lunch");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Desk & Cell");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");	
		end
		
		it "should drag and drop Config Menu Items Combo 2"	
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Night");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Desk & Cell");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 3"
		# @selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all");
		# @selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Default");
		# @selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Desk & Cell");
		# @selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		# @selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		# @selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 4"
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[3]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Weekend");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Desk & Cell");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 5"
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[3]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Override");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Desk & Cell");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 6"	
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[2]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Lunch");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Go To Voicemail");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");	
		end
		
		it "should drag and drop Config Menu Items Combo 7"	
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Night");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Go To Voicemail");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 8"	
		# @selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all");
		# @selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Default");
		# @selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Go To Voicemail");
		# @selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		# @selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		# @selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 9"	
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[3]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Weekend");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Go To Voicemail");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 10"
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[3]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Override");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Go To Voicemail");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 11"
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all internal");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[2]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Lunch");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Desk & Cell");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");	
		end
				
		it "should drag and drop Config Menu Items Combo 12"	
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all internal");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Night");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Desk & Cell");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 13"
		# @selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all internal");
		# @selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Default");
		# @selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Desk & Cell");
		# @selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		# @selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		# @selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 14"
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all internal");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[3]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Weekend");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Desk & Cell");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 15"
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all internal");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[3]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Override");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Desk & Cell");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		
		it "should drag and drop Config Menu Items Combo 16"	
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all external");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[2]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Lunch");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Desk & Cell");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");	

		it "should drag and drop Config Menu Items Combo 17"
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all external");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Night");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Desk & Cell");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		
		it "should drag and drop Config Menu Items Combo 18"	
		# @selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all external");
		# @selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Default");
		# @selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Desk & Cell");
		# @selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		# @selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		# @selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 19"		
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all external");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[3]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Weekend");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Desk & Cell");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 20"		
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all external");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[3]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Override");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Desk & Cell");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 21"	
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all external");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[2]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Lunch");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Go To Voicemail");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");	
		end
		
		it "should drag and drop Config Menu Items Combo 22"		
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all external");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Night");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Go To Voicemail");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 23"	
		# @selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all external");
		# @selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Default");
		# @selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Go To Voicemail");
		# @selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		# @selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		# @selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		# @selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 24"	
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all external");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[3]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Weekend");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Go To Voicemail");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 25"	
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all external");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[3]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Override");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Go To Voicemail");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 26"	
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[3]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Custom1");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Desk & Cell");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 27"	
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all internal");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[3]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Custom1");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Desk & Cell");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 28"		
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all external");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[3]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Custom1");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Desk & Cell");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 29"		
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[4]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Custom2");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Desk & Cell");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 30"	
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all internal");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[4]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Custom2");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Desk & Cell");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 31"	
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all external");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[4]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Custom2");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Desk & Cell");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 32"	
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[4]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Custom3");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Desk & Cell");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 33"	
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all internal");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[4]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Custom3");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Desk & Cell");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 34"
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all external");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[4]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Custom3");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Desk & Cell");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		
		it "should drag and drop Config Menu Items Combo 35"
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[3]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Custom1");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Go To Voicemail");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 36"
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all internal");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[3]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Custom1");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Go To Voicemail");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 37"	
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all external");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[3]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Custom1");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Go To Voicemail");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 38"	
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[4]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Custom2");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Go To Voicemail");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 39"	
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all internal");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[4]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Custom2");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Go To Voicemail");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 40"
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all external");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[4]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Custom2");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Go To Voicemail");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 41"		
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[1]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[4]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Custom3");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Go To Voicemail");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 42"	
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all internal");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[4]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Custom3");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Go To Voicemail");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		end
		
		it "should drag and drop Config Menu Items Combo 43"
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmgroupsview"]/table/tbody/tr[2]/td[3]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', "all external");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmtimesview"]/table/tbody/tr[4]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', "Custom3");
		@selenium.drag_and_drop(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[2]/div', :xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div')		
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', "Go To Voicemail");
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[2]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[4]/div/div', " ");	
		@selenium.click(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/i')
		@selenium.verify_text_from_element(:xpath, '//*[@id="col-1-innerCt"]/div/div[2]/div/table/tbody/tr/td[6]/div/div', " ");
		
		it "should Add New Action Set"
		@selenium.click(:xpath, '//*[@id="fmfmactionsview"]/table/tbody/tr[2]/td[3]/div')
		sleep 5
		@selenium.drag_and_drop(:xpath, '//*[@id="AddEditActionSetActions-body"]/div/table/tbody/tr[1]', :xpath, '//*[@id="actionGroup_view"]/div/div/div/div[2]')
		@selenium.verify_text_from_element(:xpath, '//*[@id="AddEditActionSetActions-body"]/div/table/tbody/tr[1]', "Go To Voicemail");
		@selenium.click(:id, 'AddEditActionSetWindowNext-btnEl')
		@selenium.type(:id, 'actionsetconfigurationname-inputEl', "Test Action Set")
		@selenium.type(:id, 'actionsetconfigurationdescription-inputEl', "Creation of Action Set via Automation")
		@selenium.click(:id, 'AddEditActionSetWindowOk-btnEl')
		end
		
		it "should Remove Action Set"
		@selenium.click(:xpath, '//*[@id="findmefollowmeconfigurationcard"]/div/div/div/div[2]/div/a[2]')
		@selenium.click(:xpath, '//*[@id="fmfmActionsList_grid-body"]/div/table/tbody/tr[3]')
		@selenium.click(:xpath, '//*[@id="fmfmActionsList_action-innerCt"]/div/div/div/a[3]')
		end
end