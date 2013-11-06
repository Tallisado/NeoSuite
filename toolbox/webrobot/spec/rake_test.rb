require 'rake'
#$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))
import 'spec/webrobot.rake'

describe "rakefile from webtester should be found" do
	it "aa" do		
		Rake.application.init
		Rake.application.load_rakefile
		Rake.application['test:sauce'].invoke()
	end
end

