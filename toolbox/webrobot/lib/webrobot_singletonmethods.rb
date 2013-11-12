module WebRobotSingletonMethods

	def drag_and_drop(draggable_element_type, draggable_element, droppable_element_type, droppable_element)
		p "-- dragging (#{draggable_element}) and dropping into (#{droppable_element})"
		draggable = self.find_element(draggable_element_type, draggable_element)
		droppable = self.find_element(droppable_element_type, droppable_element)
		self.action.click_and_hold(draggable).perform
		self.action.drag_and_drop(draggable, droppable).perform
		self.action.release.perform
	end

	def wait_for_element_present( how, what, how_long=5)
		p("-- wait_for_element_present [ #{how.to_s}," + what + "," + how_long.to_s + " ]")
		wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long )
		wait_for_it.until { self.find_element(how, what) }
	end
	
	def relaxed_wait_for_element_present( how, what, how_long=5)
		begin
			p("-- wait_for_element_present [ #{how.to_s}," + what + "," + how_long.to_s + " ]")
			wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long )
			wait_for_it.until { self.find_element(how, what) }
		rescue
			puts "[Failure Here] .. "
		end
	end

	# @name is_element_present
	# @desc checks that the element is found repeatedly until the timer expires
	def is_element_present( how, what, how_long=5)
		p("-- check_for_element_present [ #{how.to_s}," + what + "," + how_long.to_s + " ]")
		wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long )
		wait_for_it.until { self.find_element(how, what) }
			return true
		rescue Selenium::WebDriver::Error::NoSuchElementError, Selenium::WebDriver::Error::TimeOutError => ex
			return false
	end

	# @name wait_for_element_not_present
	# @desc unused
	def wait_for_element_not_present locator, timeout = 120
		self.wait_for_condition("!selenium.isElementPresent(\"#{locator}\")", timeout)
	end

	# @name wait_for_element_visible
	# @desc unused
	def wait_for_element_visible locator, timeout = 120
		p "-- waiting for visible #{locator}"
		wait_for_element_present locator, timeout
		self.wait_for_condition("selenium.isVisible(\"#{locator}\")", timeout)
	end

	# @name wait_for_element_not_visible
	# @desc unused
	def wait_for_element_not_visible locator, timeout = 120
		wait_for_element_present locator, timeout
		self.wait_for_condition("!selenium.isVisible(\"#{locator}\")", timeout)
	end

	# @name wait_for_text_present
	# @desc unused
	def wait_for_text_present locator, timeout = 120
		self.wait_for_condition("selenium.isTextPresent(\"#{locator}\")", timeout)
	end

	# @name get_body_text
	# @desc get the context text from the body tag of the html object
	def get_body_text
		return self.get_body_text()
	end

	# @name verify_text_from_element
	# @desc verify that the text is located within the target element
	def verify_text_from_element(method, location_id, compare_value)
		p ("locating element [ " + location_id + " / " + method.to_s + " ] for the comparative text: " + compare_value)
		t = self.find_element(method, location_id).text
		p("-- current value in a given location_id: " + t)
		self.find_element(method, location_id).text.should == compare_value
		#verify { self.find_element(method, location_id).text.should == compare_value }
	end

	# @name verify_attribute_from_element
	# @desc verify that the attribute is located within the targer element
	def verify_attribute_from_element(method, location_id, location_attribute, compare_value)
		p ("locating element [ " + location_id + " / " + method.to_s + " ] @" + location_attribute + " for the comparative text: " + compare_value)
		a = self.find_element(method, location_id).attribute(location_attribute)
		p("-- current attribute value given the location and attribute name : " + a)
		a.should == compare_value
		#verify { a == compare_value }
	end

	# @name get_sessionid_from_cookie
	# @desc
	def get_sessionid_from_cookie
		a=Hash[*self.manage.all_cookies]
		a.each {|key, value| return value if key == "value".intern}
	end

	# @name clear_cookies_disabled
	# @desc unused
	def clear_cookies_disabled
		p("-- clearing browser_token cookie...")
		self.delete_cookie("browser_token", "recurse=true")
	end

	# @name clear_cookies
	# @desc clear browser's entire cookie jar
	def clear_cookies
		p("-- clearing browser cookie cache...")
		# js =  "var cookie_date = new Date ( ); cookie_date.setTime ( cookie_date.getTime() - 1 );"
		# js += " document.cookie = 'browser_token =; expires=' + cookie_date.toGMTString();"
		# p("-- javascript: " + js + "\n\n")
		# self.run_script(js)
		self.manage.delete_all_cookies
	end

	# @name force_session_expire
	# @desc clearing the cookies forces the session to be reset and will expire immediately
	def force_session_expire
		p("-- forcing browser session expire...");
		clear_cookies
	end

	# @name sleep_in_slow_mode_a
	# @desc sleep time configurable in the yaml
	def sleep_in_slow_mode time=1
		sleep time if @CONFIG["slow_mode"]
	end
	
	# @name wait_for_page_and_verify_text
	# @desc wait for page to load and verify text
	def wait_for_page_and_verify_text(text)
		self.wait_for_page_to_load(120000)
		check_page_and_verify_text(text)
	end

	# @name check_page_and_verify_text
	# @desc check the page for any abnormalities and verify text
	def check_page_and_verify_text(text)
			#check_page(self.find_element(:id, "body").text)
		verify_text(text)
	end
	
	# @name check
	# @desc combobox will be checked if unchecked (sencha logic looks at class to see if DOM is marked as 'checked)
	def check(method, element)
		if (element.include? "inputEl") then
			puts "-- sencha element found"
			if !self.find_element(method, element[0..-9]).attribute("class").include? "x-form-cb-checked"
				do_click = true
			end
		else
			puts "-- non-sencha element found"
			if !self.find_element(method, element).selected?
				do_click = true
			end
		end

		if (do_click)
			self.find_element(method, element).click
			puts "-- checking element"
		end
	end

	# @name uncheck
	# @desc combobox will be unchecked if checked (sencha logic looks at class to see if DOM is marked as 'checked)
	def uncheck(method, element)
		if (element.include? "inputEl") then
		puts "-- sencha element found"
		if self.find_element(method, element[0..-9]).attribute("class").include? "x-form-cb-checked"
			do_click = true
		end
		else
			puts "-- non-sencha element found"
		if self.find_element(method, element).selected?
			do_click = true
		end
		end

		if (do_click)
			self.find_element(method, element).click
			puts "-- unchecking element"
		end
	end

	# @name click
	# @desc sends a click event to the targeted element. (if jQuery, we execute the js to click that element)
	def click(method, element)
		# -- 'element' could be a javascript, then we need to call 'run_script' instead of 'click'
		if /jQuery/.match(element)
			p("-- running script: " + element)
			self.run_script(element)
		else
			p("-- clicking on element: " + element.to_s + " by " + method.to_s)
			self.find_element(method, element).click
		end
	end
	
	# @name double_click
	# @desc sends an action sequence to the target element to perform a double click
	def double_click(method, element)
		clickable = self.find_element(method, element)
		p "-- double clicking (#{clickable})"
		self.action.move_to(clickable).perform
		self.action.move_to(clickable).double_click.perform
	end

	# @name click_text_from_combobox
	# @desc clicks the text from the combobox specified. (built in timer that will wait for the combobox dropdown to be populated before click is issued) 
	def click_text_from_combobox(method, element, contains_text_to_select)
		p "-- waiting for element"
		wait_for_element_present(method, element, 10)
		p "-- clicking element"
		self.find_element(method, element).click
		sleep 1

		i = 0
		elements = self.find_elements(:xpath, "//li[contains(@class, 'x-boundlist-item') and contains(text(),'"+contains_text_to_select+"')]")
		while i < elements.length do
			if elements[i].displayed?
				elements[i].click
			# rescue Selenium::WebDriver::Error::StaleElementReferenceError =>
				# sleep 2
				# elements[i].click
			# end
			else
				i = i+1
			end
		end
	end

	# @name mouseover_and_click
	# @desc sends an action to the elements to be clicked after it receives a mouseover event (needed for mouseover javascript validation)
	def mouseover_and_click(method, element_over, element_click)
		p("-- clicking on element: " + element_click.to_s + " by " + method.to_s)
		self.action.move_to(self.find_element(method, element_over)).perform
		sleep 5
		self.find_element(method, element_click).click
	end

	# @name click_by_script
	# @desc issues a javascript click() event to the element
	def click_by_script(element_click)
		p("-- execute_script clicking on element: " + element_click.to_s)
		self.execute_script("document.getElementById('#{element_click}').click();");
	end

	# @name type
	# @desc sends text to the target element (built in sleep to allow text to populate box)
	def type(method, element, text)
		p("-- typing text ['#{text}'] into element ['#{element}'] by ['#{method}']")
		self.find_element(method, element).send_keys text
		sleep 0.2
	end

	# @name clear
	# @desc removes all the text from the target element
	def clear(method, element)
		p("-- clearing text from element ['#{element}'] by ['#{method}']")
		self.find_element(method, element).clear
	end

	# @name select
	# @desc selects the elements with the given option from a 'select' dom object
	def select(element, option)
		p("-- selecting option ['#{option}'] from select element ['#{element}']")
		self.select(element, option)
	end

	# @name select_by
	# @desc finds the element of the select item, and issues a select_by :text command to find the text in the available options
	def select_by(method, element, how, what)
		p("-- selecting option ['#{what}'] from element ['#{element}'] by ['#{method}']")
		#self.find_element(method, element).select_by(how, what)
		Selenium::WebDriver::Support::Select.new(self.find_element(:id => element)).select_by :text, what
		#puts self.find_element(method, element).options
	end

	# @name switch_frame
	# @desc allows frame switching, from default to the one provided
	def switch_frame(frame_id)
		p("-- switching to frame ['#{frame_id}']")
		self.switch_to.frame(frame_id)
	end
	
	# @name switch_frame
	# @desc
	def switch_frame_default()
		p("-- switching to default frame")
		self.switch_to.default_content
	end
end
