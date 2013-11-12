require 'rake'
#$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))
import 'spec/webrobot.rake'

describe "import webrobot.rake" do
	it "should init and load the rakefile" do		
		Rake.application.init
		Rake.application.load_rakefile
		Rake.application['test:sauce'].invoke()
	end
end

