$LOAD_PATH.unshift File.dirname(__FILE__)

require 'helper_methods'
require 'sauce'
require 'sauce/rspec'

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
	
   # @name read_yaml_file
   # @desc 
   def is_element_present( how, what, how_long=5)
      p("-- check_for_element_present [ #{how.to_s}," + what + "," + how_long.to_s + " ]")
	  wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long )
	  wait_for_it.until { self.find_element(how, what) }
   	     return true
	  rescue Selenium::WebDriver::Error::NoSuchElementError, Selenium::WebDriver::Error::TimeOutError => ex
	     return false
   end

   # @name read_yaml_file
   # @desc 
   def wait_for_element_not_present locator, timeout = 120
      self.wait_for_condition("!selenium.isElementPresent(\"#{locator}\")", timeout)
   end

   # @name read_yaml_file
   # @desc 
   def wait_for_element_visible locator, timeout = 120
      p "-- waiting for visible #{locator}"
      wait_for_element_present locator, timeout
      self.wait_for_condition("selenium.isVisible(\"#{locator}\")", timeout)
   end

   # @name read_yaml_file
   # @desc 
   def wait_for_element_not_visible locator, timeout = 120
      wait_for_element_present locator, timeout
      self.wait_for_condition("!selenium.isVisible(\"#{locator}\")", timeout)
   end

   # @name read_yaml_file
   # @desc 
   def wait_for_text_present locator, timeout = 120
      self.wait_for_condition("selenium.isTextPresent(\"#{locator}\")", timeout)
   end

   # @name read_yaml_file
   # @desc 
   def get_body_text
      return self.get_body_text()
   end
	 
	    # @name read_yaml_file
   # @desc 
   def verify_text_from_element(method, location_id, compare_value)
      p ("locating element [ " + location_id + " / " + method.to_s + " ] for the comparative text: " + compare_value)
	  t = self.find_element(method, location_id).text
	  p("-- current value in a given location_id: " + t)
	  verify { self.find_element(method, location_id).text.should == compare_value }
	  #verify { t.to_s == compare_value.to_s }
   end   
   
   # @name read_yaml_file
   # @desc 
   def verify_attribute_from_element(method, location_id, location_attribute, compare_value)
      p ("locating element [ " + location_id + " / " + method.to_s + " ] @" + location_attribute + " for the comparative text: " + compare_value)
	  a = self.find_element(method, location_id).attribute(location_attribute)
	  p("-- current attribute value given the location and attribute name : " + a)
	  verify { a == compare_value }
   end
	 
	   # @name read_yaml_file
   # @desc 
   def get_sessionid_from_cookie
      a=Hash[*self.manage.all_cookies]
      a.each {|key, value| return value if key == "value".intern}
   end
   
   # @name read_yaml_file
   # @desc 
   # -- clear all necessary cookies
   def clear_cookies_disabled
      p("-- clearing browser_token cookie...")
      self.delete_cookie("browser_token", "recurse=true")
   end

   # @name read_yaml_file
   # @desc 
   # -- clear cookies in a creative way
   def clear_cookies
      p("-- clearing browser cookie cache...")
      # js =  "var cookie_date = new Date ( ); cookie_date.setTime ( cookie_date.getTime() - 1 );"
      # js += " document.cookie = 'browser_token =; expires=' + cookie_date.toGMTString();"
      # p("-- javascript: " + js + "\n\n")
      # self.run_script(js)
	  self.manage.delete_all_cookies
   end
   
   # @name read_yaml_file
   # @desc 
   def force_session_expire
      p("-- forcing browser session expire...");
      clear_cookies
   end

   # @name read_yaml_file
   # @desc 
   def sleep_in_slow_mode time=1
     sleep time if @CONFIG["slow_mode"]
   end

   # -- wait for page to load and verify text
   # @name read_yaml_file
   # @desc 
   def wait_for_page_and_verify_text(text)
      self.wait_for_page_to_load(120000)
      check_page_and_verify_text(text)
   end

   # -- check the page for any abnormalities and verify text
   # @name read_yaml_file
   # @desc 
   def check_page_and_verify_text(text)
      #check_page(self.find_element(:id, "body").text)
      verify_text(text)
   end
   
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

   # -- click on something
   # @name read_yaml_file
   # @desc 
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
   
   def double_click(method, element)
	 clickable = self.find_element(method, element)
	 p "-- double clicking (#{clickable})"	 
	 self.action.move_to(clickable).perform
	 self.action.move_to(clickable).double_click.perform
   end 
   
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
	
   # -- click on something that needs a mouse over
   # @name read_yaml_file
   # @desc 
   def mouseover_and_click(method, element_over, element_click)
		p("-- clicking on element: " + element_click.to_s + " by " + method.to_s)
		self.action.move_to(self.find_element(method, element_over)).perform
		sleep 5
		self.find_element(method, element_click).click
		end   
   
   # -- click on something that needs a mouse over
   # @name read_yaml_file
   # @desc 
   def click_by_script(element_click)
	 p("-- execute_script clicking on element: " + element_click.to_s)
	 self.execute_script("document.getElementById('#{element_click}').click();");
   end

   # @name read_yaml_file
   # @desc 
   def type(method, element, text)
		p("-- typing text ['#{text}'] into element ['#{element}'] by ['#{method}']")
		self.find_element(method, element).send_keys text
		sleep 0.2
   end
   
   # @name read_yaml_file
   # @desc 
   def clear(method, element)
      p("-- clearing text from element ['#{element}'] by ['#{method}']")
	  self.find_element(method, element).clear
   end
	
   # -- select something
   # @name read_yaml_file
   # @desc 
   def select(element, option)
      p("-- selecting option ['#{option}'] from select element ['#{element}']")
      self.select(element, option)
   end

   # -- select something
   # @name read_yaml_file
   # @desc 
   def select_by(method, element, how, what)
      p("-- selecting option ['#{how}'] by ['#{what}'] from element ['#{element}'] by ['#{method}']")
      #self.find_element(method, element).select_by(how, what)
	  Selenium::WebDriver::Support::Select.new(self.find_element(:id => element)).select_by :text, what
      #puts self.find_element(method, element).options
   end
   
   def switch_frame(frame_id)
	  p("-- switching to frame ['#{frame_id}']")
	  self.switch_to.frame(frame_id)
   end
   
   def switch_frame_default()
	  p("-- switching to default frame")
	  self.switch_to.default_content
   end
end


RSpec.configure do |config|
	config.include HelperMethods
	if ! ENV['WR_INTERFACE'].nil? 
		if ENV['WR_INTERFACE'].match('sauce')
			config.filter_run_including :sauce => true
		elsif ENV['WR_INTERFACE'].match('local')
			config.filter_run_including :local => true
		end
	end
  config.before(:each) do
	  #puts -- Interface is: ENV['WR_INTERFACE']
		if self.example.metadata[:local] == true && ENV['WR_INTERFACE'] != "sauce" ||
				self.example.metadata[:sauce] == true && ENV['WR_INTERFACE'] != "sauce"
			puts "-- [LOCAL] Starting firefox :"
			@selenium = Selenium::WebDriver.for :firefox
			@selenium.manage.timeouts.implicit_wait = 35
			@selenium.manage.timeouts.script_timeout = 30
			@selenium.manage.timeouts.page_load = 500
			@selenium.extend WebRobotSingletonMethods
		end
  end
  config.after(:each) do
		if self.example.metadata[:local] == true
				puts "-- [LOCAL] quit firefox"
				@selenium.quit if defined?(@selenium)
		end
  end
  config.after(:suite) do
    ENV.delete('WR_RUNFILTER')
    ENV.delete('WR_FORCEDISPLAY')
    ENV.delete('WR_FFONLY')
    ENV.delete('WR_NOTUNNEL')
    ENV.delete('WR_URL')
    ENV.delete('WR_USERNAME')
    ENV.delete('WR_USERPASS')
  end
end

#export SAUCE_USERNAME=esthernaholowaa
#export SAUCE_ACCESS_KEY=4c2695d1-33c5-4d38-acb4-69dbb79f0b8c

#export SAUCE_USERNAME=talliskane
#export SAUCE_ACCESS_KEY=6c3ed64b-e065-4df4-b921-75336e2cb9cf

Sauce.config do |c|
  if !ENV['WR_NOTUNNEL'].nil? || ENV['WR_INTERFACE'] == 'local' 
		puts "[webrobot] helper.rb - NO TUNNEL"
		c[:start_tunnel] = false
	end
	if ! ENV['WR_FFONLY'].nil?  
		c[:browsers] = [
			["Linux", "Firefox", "19"]
		]
	else
		c[:browsers] = [
			["Windows 7", "Internet Explorer", "9"],
			["Linux", "Firefox", "19"],
			["OSX 10.6", "Chrome", nil]
		]
	end

end