require File.join(File.dirname(__FILE__), "./../lib/helper")

describe "cloud browser", :sauce => true do
	it "should open browser remotely" do
		@selenium.navigate.to "http://www.google.ca"   
		@selenium.title.should eql("Google")
	end
end

describe "local browser", :local => true do
	it "should open browser locally" do
		puts "hit the page"
		@selenium.navigate.to "http://www.google.ca"   
		puts "hit the copntrol"
		@selenium.title.should eql("Google")
	end
end
