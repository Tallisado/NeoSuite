require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/helper")

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


# local browser
# -- [LOCAL] Starting firefox :
# -- [LOCAL] quit firefox
  # should open browser locally

# Finished in 7.48 seconds
# 1 example, 0 failures