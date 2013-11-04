#####################################################################################################################
# RubySuite
# API layer for the webtester (abstraction layer), containing all the custom ruby webdriver classes used in webtester.
# -- framework components
#		- Ruby 1.9.1
#		+ require_relative
#		+ selenium-webdriver
#
# Date:  	Aug 7 2013
# Author:	tallis.vanek@adtran.com
##################################################################################################################### 

require 'yaml'
require "rubygems"
require "rspec"
require "selenium-webdriver"
require_relative "./../lib/macros"
require_relative "./../lib/base_test"
require_relative "./../lib/user"
require 'fileutils'
require "test/unit"

class RubySuite
   attr_accessor :selenium, :test_name, :CONFIG, :host, :port, :base_url, :browser, :debug_mode, :suite_root, :common, :platform, :onlylocal

   def initialize(options)
      @suite_root = File.expand_path "#{File.dirname(__FILE__)}/.."
      # -- loading global properties from yaml
      @CONFIG = read_yaml_file(@suite_root+"/env.yaml")
      # -- loading user-defined properties from yaml
      if File.exist?(@suite_root+"/user.env.yaml")
         YAML::load(File.read(@suite_root+"/user.env.yaml")).each_pair { |key, value|
            @CONFIG[key] = value if @CONFIG[key] != nil
         }
      end
	  # MIGHT CHANGE
	  @accept_next_alert = true
	  @verification_errors = []
	  @verification_counter = 0
	  
      # -- loading common id hash
      @common = YAML::load(File.read(@suite_root+"/lib/common.yaml"))
	  @onlylocal = ENV['qa.onlylocal'] == "yes" ? true : false
      @host = @CONFIG['selenium_host']
      @port = @CONFIG['selenium_port']
      @browser = ENV['SELENIUM_BROWSER'].to_s == '' ? @CONFIG['browser'] : ENV['SELENIUM_BROWSER']
      @version = ENV['SELENIUM_VERSION'].to_s == '' ? @CONFIG['version'] : ENV['SELENIUM_VERSION']	  
      @platform = ENV['SELENIUM_PLATFORM'].to_s == '' ? @CONFIG['platform'] : ENV['SELENIUM_PLATFORM']
      @debug_mode = @CONFIG['debug_mode']
      @base_url = @CONFIG['base_url']
      # -- setting env for a given test
      set_test_name(options[:test_name])
      # -- do init
      do_init
   end

   # -- utility method for reading yaml data
   # @name read_yaml_file
   # @desc 
   def read_yaml_file(file)
      if File.exist?(file)
         return YAML::load(File.read(file))
      end
      raise "-- ERROR: file doesn't exist: " + file
   end
   
   # -- check connection to Selenium RC
   # @name check_connection
   # @desc checks the http connection of WebDriver service; returns true if successful
   def check_connection
      one_wait = 5
      max_wait = 15
      request = Net::HTTP::Get.new('/selenium-server/')
      wait = 0;
      while (wait < max_wait)
          begin
              response = Net::HTTP.start(@host, @port) {|http|
                  http.request(request)
              }
              break if Net::HTTPForbidden === response
              break if Net::HTTPNotFound === response
              break if Net::HTTPSuccess === response
              # When we try to connect to a down server with an Apache proxy,
              # we'll get Net::HTTPBadGateway and get here
          rescue Errno::ECONNREFUSED
              # When we try to connect to a down server without an Apache proxy,
              # such as a dev instance, we'll get here
          end
          sleep one_wait;
          wait += one_wait
      end
      if (wait == max_wait)
          p("-- ERROR: couldn't connect to Selenium RC on " + @host)
          return false
      end
      return true
   end
   
   def capabilities
	{
	  'browserName' => '#{browser}',
	  'platform' => '#{platform}',
	  'device' => 'SauceTime',
	  'name' => '#{@test_name}',
	}
	end

   # -- start selenium
   # @name do_init
   # @desc starts the indicated browser with the WebDriver DLL injected
   def do_init
      # if (!check_connection)
         # clean_exit(false)
      # end
      begin
         p("-- ONLY_LOCAL : " + @onlylocal.to_s)
		 
		# ENV.to_hash.each do |key, value|
			# puts("#{key}\t#{value}")
		# end
		 
		if (@onlylocal) then
			p("-- LOCAL DEBIAN")
			ENV['DISPLAY'] = ':5'
			case @CONFIG["browser"]
			when /firefox/							
				p("-- BROWSER: Firefox")
				@selenium = Selenium::WebDriver.for :firefox

			when /chrome/
				# DO THIS
				@selenium = Selenium::WebDriver.for :chrome
				p("-- LOCAL DEBIAN")
				p("-- BROWSER: Chrome")
			end		
			
			@selenium.manage.window.maximize if @CONFIG["fullscreen_mode"]
			# we missing timeoput @selenium.manage.timeouts.implicit_wait = 30
		else
			p("-- ENV : " + @platform)
			p("-- BROWSER : " + @browser)
			p("-- VERSION : " + @version)
			
			caps = Selenium::WebDriver::Remote::Capabilities.new
			caps.browser_name = @browser
			caps.version = @version
			caps.platform = @platform
			if (@platform.include? "Windows") then
				# caps[:"screen-resolution"] = "1280x1024"
				caps[:"screen-resolution"] = "1024x768"
			end
			caps[:name] = "WebTester Suite"
			#puts caps.methods
						
			@selenium = Selenium::WebDriver.for(
			:remote,
			:url => "http://esthernaholowaa:4c2695d1-33c5-4d38-acb4-69dbb79f0b8c@ondemand.saucelabs.com:80/wd/hub",
			:desired_capabilities => caps)
		end
      rescue => e
         do_fail("ERROR: " + e.inspect.to_s + $!.to_s)
         clean_exit(false)
      end
   end

   # -- set test_name
   def set_test_name(new_name)
      @test_name = new_name
      p "\n:: {BEGIN} [#{@test_name}] ++++++++++++++++++\n\n"
   end

   # -- do_fail
   def do_fail(s)
      p(s)
      raise("error")
   end

   # -- generate random number
   # @name read_yaml_file
   # @desc 
   def random_n
      return rand(50000).to_s.rjust(5,'0')
   end
   
   # @name read_yaml_file
   # @desc
   def close_alert_and_get_its_text()
     alert = @selenium.switch_to().alert()
     atext = alert.text
     if (@accept_next_alert) then
       alert.accept()
     else
       alert.dismiss()
     end
     atext
	 ensure
       @accept_next_alert = true
   end
   
   # -- check the page for any abnormalities
   # @name read_yaml_file
   # @desc 
   def check_page(page)
      # -- if error is found, it will dump first 2000 characters of the page to the screen
      raise "-- [ERROR] User name incorrect !\n\n" if /User name or password is incorrect/.match(page)
      if /An Error Occurred/.match(page)
         p ("-- Error occured, dumping partial stack trace to the screen...")
         page[0,2000].each { |s| p s } if page.length >= 2000
         raise "-- [ERROR] Exception occured !\n\n"
      end
   end

   # @name read_yaml_file
   # @desc 
   def verify(&blk)
      p "-- Calculating verification response ... --"
	  @verification_counter += 1
	  yield
	  p("-- OK: Verify success!")		
	  rescue => ex
	     @verification_errors << ex
		 @passed = false
		 p ("-- [ERROR] Verification Failed ! The following error was captured:")
		 p (ex)
		 p ("-- [=============================================================]")
		 p ("")
   end
  
   # -- verify particular element
   # def verify_element(element)
      # p("-- Verifying page elements...")
      # raise "-- [ERROR] not able to verify element: #{element}" if !element_exist?(element)
      # p("-- OK: page element verified [ #{element} ] !")
   # end

   # -- verify text
   # @name read_yaml_file
   # @desc 
   def verify_text(text)
      p("-- Verifying page text: [ #{text} ]")
      sleep_in_slow_mode 5
      verify { @selenium.find_element(:css, "body").text.include? text }
	  #if !@selenium.find_element(:css, "body").text.include? text
      #   p("-- [DEBUG] (Verify Text) not found , page text is currently: " + @selenium.find_element(:css, "body").text )
      #   raise "-- [ERROR] not able to verify text: #{text}"
      #end
      #p("-- OK: page text verified [ #{text} ] !")
   end

   # @name read_yaml_file
   # @desc 
   def get_sessionid_from_cookie
      a=Hash[*@selenium.manage.all_cookies]
      a.each {|key, value| return value if key == "value".intern}
   end
   
   # @name read_yaml_file
   # @desc 
   # -- clear all necessary cookies
   def clear_cookies_disabled
      p("-- clearing browser_token cookie...")
      @selenium.delete_cookie("browser_token", "recurse=true")
   end

   # @name read_yaml_file
   # @desc 
   # -- clear cookies in a creative way
   def clear_cookies
      p("-- clearing browser cookie cache...")
      # js =  "var cookie_date = new Date ( ); cookie_date.setTime ( cookie_date.getTime() - 1 );"
      # js += " document.cookie = 'browser_token =; expires=' + cookie_date.toGMTString();"
      # p("-- javascript: " + js + "\n\n")
      # @selenium.run_script(js)
	  @selenium.manage.delete_all_cookies
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
      @selenium.wait_for_page_to_load(120000)
      check_page_and_verify_text(text)
   end

   # -- check the page for any abnormalities and verify text
   # @name read_yaml_file
   # @desc 
   def check_page_and_verify_text(text)
      #check_page(@selenium.find_element(:id, "body").text)
      verify_text(text)
   end
   
   def check(method, element)
	  if (element.include? "inputEl") then
		puts "-- sencha element found"
		if !@selenium.find_element(method, element[0..-9]).attribute("class").include? "x-form-cb-checked"
			do_click = true
		end
	  else
	    puts "-- non-sencha element found"
		if !@selenium.find_element(method, element).selected?
		   do_click = true
		end
	  end
	  
	  if (do_click) 
	    @selenium.find_element(method, element).click
		puts "-- checking element"
      end  
   end
   
   def uncheck(method, element)
	  if (element.include? "inputEl") then
		puts "-- sencha element found"
		if @selenium.find_element(method, element[0..-9]).attribute("class").include? "x-form-cb-checked"
			do_click = true
		end
	  else
	    puts "-- non-sencha element found"
		if @selenium.find_element(method, element).selected?
		   do_click = true
		end
	  end
	  
	  if (do_click) 
	    @selenium.find_element(method, element).click
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
         @selenium.run_script(element)
      else
		p("-- clicking on element: " + element.to_s + " by " + method.to_s)
		@selenium.find_element(method, element).click
      end
   end
   
   def double_click(method, element)
	 clickable = @selenium.find_element(method, element)
	 p "-- double clicking (#{clickable})"	 
	 @selenium.action.move_to(clickable).perform
	 @selenium.action.move_to(clickable).double_click.perform
   end 
   
   def click_text_from_combobox(method, element, contains_text_to_select)
     p "-- waiting for element"
	 wait_for_element_present(method, element, 10)
	 p "-- clicking element"
     @selenium.find_element(method, element).click	 
	 sleep 1
	 
 	 i = 0
	 elements = @selenium.find_elements(:xpath, "//li[contains(@class, 'x-boundlist-item') and contains(text(),'"+contains_text_to_select+"')]")
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
	@selenium.action.move_to(@selenium.find_element(method, element_over)).perform
	sleep 5
	@selenium.find_element(method, element_click).click
   end   
   
   # -- click on something that needs a mouse over
   # @name read_yaml_file
   # @desc 
   def click_by_script(element_click)
	 p("-- execute_script clicking on element: " + element_click.to_s)
	 @selenium.execute_script("document.getElementById('#{element_click}').click();");
   end

   # @name read_yaml_file
   # @desc 
   def type(method, element, text)
		p("-- typing text ['#{text}'] into element ['#{element}'] by ['#{method}']")
		@selenium.find_element(method, element).send_keys text
		sleep 0.2
   end
   
   # @name read_yaml_file
   # @desc 
   def clear(method, element)
      p("-- clearing text from element ['#{element}'] by ['#{method}']")
	  @selenium.find_element(method, element).clear
   end
	
   # -- select something
   # @name read_yaml_file
   # @desc 
   def select(element, option)
      p("-- selecting option ['#{option}'] from select element ['#{element}']")
      @selenium.select(element, option)
   end

   # -- select something
   # @name read_yaml_file
   # @desc 
   def select_by(method, element, how, what)
      p("-- selecting option ['#{how}'] by ['#{what}'] from element ['#{element}'] by ['#{method}']")
      #@selenium.find_element(method, element).select_by(how, what)
	  Selenium::WebDriver::Support::Select.new(@selenium.find_element(:id => element)).select_by :text, what
      #puts @selenium.find_element(method, element).options
   end
   
   def switch_frame(frame_id)
	  p("-- switching to frame ['#{frame_id}']")
	  @selenium.switch_to.frame(frame_id)
   end
   
   def switch_frame_default()
	  p("-- switching to default frame")
	  @selenium.switch_to.default_content
   end

   def p(s)
      puts s
   end
   
   def testheader(s)
      puts "\n-- {TESTCASE} [#{s.to_s}]"
      #puts s
   end

   # -- setup proper absolute url based on a given relative url
   def proper_base_url(relative_url)
      p("-- evaluating the proper base url to use based on config settings: " + relative_url)
      if (ENV['qa.base.url'] != nil and ENV['qa.base.url'] != "")
         p("-- using ENV - URL: " + ENV['qa.base.url'])
         proper_base = (ENV['qa.base.url'] + relative_url)
      else
         p("-- using env.yaml file URL: " + @base_url)
         proper_base = (@base_url + relative_url)
      end
   end

   # -- setup proper file uri needed for any operations involving selenium.attach_file
   def proper_file_uri(file)
      p("-- setting up proper file uri for file: [ #{file} ]")
      case RUBY_PLATFORM
        when /cygwin/, /mswin32/, /i386-mingw32/
           new_path = file.gsub(/C:/,'')
           p("-- new_path (windows only) = #{new_path}")
           return "file://" + new_path
        else
           return "file://" + file
      end
   end
   
   # @name read_yaml_file
   # @desc 
   def verify_text_from_element(method, location_id, compare_value)
      p ("locating element [ " + location_id + " / " + method.to_s + " ] for the comparative text: " + compare_value)
	  t = @selenium.find_element(method, location_id).text
	  p("-- current value in a given location_id: " + t)
	  verify { @selenium.find_element(method, location_id).text.should == compare_value }
	  #verify { t.to_s == compare_value.to_s }
   end   
   
   # @name read_yaml_file
   # @desc 
   def verify_attribute_from_element(method, location_id, location_attribute, compare_value)
      p ("locating element [ " + location_id + " / " + method.to_s + " ] @" + location_attribute + " for the comparative text: " + compare_value)
	  a = @selenium.find_element(method, location_id).attribute(location_attribute)
	  p("-- current attribute value given the location and attribute name : " + a)
	  verify { a == compare_value }
   end

   # # -- extract page element and compare its value to a given one
   # def extract_text_and_compare(location_id, compare_value)
      # p("-- checking location_id [ " + location_id + " ] for the following value: " + compare_value)
      # p("-- current value in a given location_id: " + @selenium.get_text(location_id))
      # if (@selenium.get_text(location_id) != compare_value)
         # raise "-- ERROR: " + compare_value + "not found in [ " + location_id + " ]"
      # else
         # p("-- OK: [ " + compare_value + " ] found!")
      # end
   # end

   # # -- extract text field element and compare its value to a given one
   # def extract_value_and_compare(location_id, compare_value)
      # p("-- checking location_id [ " + location_id + " ] for the following value: " + compare_value)
      # p("-- current value in a given location_id: " + @selenium.get_text(location_id))
      # if (@selenium.get_value(location_id) != compare_value)
         # raise "-- ERROR: " + compare_value + "not found in [ " + location_id + " ]"
      # else
         # p("-- OK: [ " + compare_value + " ] found!")
      # end
   # end

   # def wait_for_element_present locator, timeout = 120
      # @selenium.wait_for_condition("selenium.isElementPresent(\"#{locator}\")", timeout)
   # end
   
   # @name read_yaml_file
   # @desc 
	def wait_for_element_present( how, what, how_long=5)
		p("-- wait_for_element_present [ #{how.to_s}," + what + "," + how_long.to_s + " ]")
		wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long )
		wait_for_it.until { @selenium.find_element(how, what) }
	end
	
   # @name read_yaml_file
   # @desc 
   def is_element_present( how, what, how_long=5)
      p("-- check_for_element_present [ #{how.to_s}," + what + "," + how_long.to_s + " ]")
	  wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long )
	  wait_for_it.until { @selenium.find_element(how, what) }
   	     return true
	  rescue Selenium::WebDriver::Error::NoSuchElementError, Selenium::WebDriver::Error::TimeOutError => ex
	     return false
   end

   # @name read_yaml_file
   # @desc 
   def wait_for_element_not_present locator, timeout = 120
      @selenium.wait_for_condition("!selenium.isElementPresent(\"#{locator}\")", timeout)
   end

   # @name read_yaml_file
   # @desc 
   def wait_for_element_visible locator, timeout = 120
      p "-- waiting for visible #{locator}"
      wait_for_element_present locator, timeout
      @selenium.wait_for_condition("selenium.isVisible(\"#{locator}\")", timeout)
   end

   # @name read_yaml_file
   # @desc 
   def wait_for_element_not_visible locator, timeout = 120
      wait_for_element_present locator, timeout
      @selenium.wait_for_condition("!selenium.isVisible(\"#{locator}\")", timeout)
   end

   # @name read_yaml_file
   # @desc 
   def wait_for_text_present locator, timeout = 120
      @selenium.wait_for_condition("selenium.isTextPresent(\"#{locator}\")", timeout)
   end

   # @name read_yaml_file
   # @desc 
   def get_body_text
      return @selenium.get_body_text()
   end
   
   # -- operations on DIR(s)
   def rm_dir(dir)
      if File.directory?(dir)
         p("-- removing dir: " + dir)
         FileUtils.rm_r(dir)
      end
   end

   def mkdir(dir)
      if !File.directory?(dir)
         p("-- creating dir: " + dir)
         FileUtils.mkdir_p(dir)
      end
   end

   def setup_dir(dir)
      rm_dir(dir)
      mkdir(dir)
   end

   # -- connect to db
   def mysql_open
      begin
         #@dbh = Mysql.real_connect("10.7.144.128", "charlie", "m1ll3r", "adz")
         @dbh = Mysql.real_connect(@CONFIG['mysql_host'], @CONFIG['mysql_user'], @CONFIG['mysql_password'], @CONFIG['mysql_db'])
         # -- debug: get server version string and display it
         #puts "Server version: " + @dbh.get_server_info
      rescue Mysql::Error => e
         p("-- MySql Error code: #{e.errno}")
         p("-- MySql Error message: #{e.error}")
         p("-- MySql Error SQLSTATE: #{e.sqlstate}") if e.respond_to?("sqlstate")
         mysql_close
         clean_exit(false)
      end
   end

   # -- db close
   def mysql_close
      begin
         # -- disconnect from server
         @dbh.close if @dbh
      rescue Mysql::Error => e
         p("-- MySql Error code: #{e.errno}")
         p("-- MySql Error message: #{e.error}")
         p("-- MySql Error SQLSTATE: #{e.sqlstate}") if e.respond_to?("sqlstate")
         clean_exit(false)
      end
   end

   # -- mysql queries
   def mysql_q(q)
      if @dbh
         begin
            #[12698887, 10588603, 12698885, 12695201, 12061713].each  { |b|
            #   puts("-- checking id: " + b.to_s)
            #res = @dbh.query("select status_from_user from banner where banner_id = #{b.to_s}")
            res = @dbh.query(q)
            res.each { |row| yield row }
            #   printf "%s, %s\n", row[0], row[1]
               #puts "Number of rows returned: #{res.num_rows}\n\n"
               #res.free
            #}
         rescue Mysql::Error => e
            p("-- Error code: #{e.errno}")
            p("-- Error message: #{e.error}")
            p("-- Error SQLSTATE: #{e.sqlstate}") if e.respond_to?("sqlstate")
            mysql_close
            clean_exit(false)
         end
      else
      end
   end

   # -- check pop mail
   # def pop_mail(login, password)
      # all_mails = []
      # ok = true
      # begin
         # Net::POP.enable_ssl(OpenSSL::SSL::VERIFY_NONE)
         # Net::POP.start(@common['pop_host'], @common['pop_port'], login, password) do |pop|
            # if pop.mails.empty?
               # p '-- (pop) No mail.'
            # else
               # i = 0
               # pop.each_mail do |m|
                  # #exit if i > 20
                  # p "-- (pop) >>> new message ..."
                  # all_mails.push(m.pop)
                  # m.delete #can be deleted if each_mail will be replaced with delete_all
                  # p "-- (pop) >>> end ..."
                  # i=i+1
               # end
            # end
         # end
      # rescue Net::POPAuthenticationError => err
         # p err
         # ok = !ok
         # unless ok
            # retry
         # else
            # raise
         # end
      # end
      # return all_mails
   # end
   
   def drag_and_drop(draggable_element_type, draggable_element, droppable_element_type, droppable_element)
    p "-- dragging (#{draggable_element}) and dropping into (#{droppable_element})"
    draggable = @selenium.find_element(draggable_element_type, draggable_element)
    droppable = @selenium.find_element(droppable_element_type, droppable_element)
	
	@selenium.action.click_and_hold(draggable).perform
	@selenium.action.drag_and_drop(draggable, droppable).perform
	@selenium.action.release.perform
   end

   # -- clean exit
   def clean_exit(status)
      p "-- exiting test framework..."
      begin
         if (@debug_mode)
            if (status)
               @selenium.quit if defined?(@selenium)
            end
         else
            @selenium.quit if defined?(@selenium)
         end
      rescue => e
         p("ERROR: ")
         p e.inspect
         p e.backtrace
         status = false
      ensure
         if (status && @verification_errors == [])
            p "-->"
            p "-- PASSED !"
			p "-- VERIFICATIONS EXECUTED: (#{@verification_counter.to_s})"			
			p "-- VERIFICATION ERRORS: (#{@verification_errors.length})"

            p "-->"
            exit @CONFIG['STATUS_PASSED']
         else
			if @verification_errors != []
				p "-->"
				p "-- FAILURE WITH PARTIAL PASSING !"
				p "-- VERIFICATIONS EXECUTED: (#{@verification_counter.to_s})"
				p "-- VERIFICATION ERRORS: (#{@verification_errors.length})"
				p "-->"	
				p "[++++++] VERIFICATION LISTING:"
				p @verification_errors
				p "[------] VERIFICATION"
				p ""
			else 
				p "-->"
				p "-- FAILED !"
				p "-->"			
			end
			
            exit @CONFIG['STATUS_FAILED']
         end
      end
   end
end
