require_relative "../../toolbox/ssh_commander/lib_commander"
require File.join(File.dirname(__FILE__), "../../toolbox/webrobot/lib/webrobot_core")

describe "NeoSuite DryRun", :local => true do
	it "should allow ruby files to be executed" do
		sc = ShellCommander.new(:host => "10.10.9.129", :user => "admin", :password => "password")
		expect { sc.exec("en") }.to_not raise_error
	end
end
