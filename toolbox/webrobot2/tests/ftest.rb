# @author bigt
# @executeArgs
# @keywords tallis
# @description test to demo google search
puts Dir.pwd
require File.join(Dir.pwd, "lib/headless.rb")
Headless.ly do
	driver = Selenium::WebDriver.for :firefox
  driver.navigate.to 'http://google.com'
  puts driver.title 
end