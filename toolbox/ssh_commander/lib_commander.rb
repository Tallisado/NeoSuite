require 'net/ssh'
require 'net/ssh/telnet'

class ShellCommander
  attr_accessor :telnet_session
	
	@ssh_session
	@telnet_session
	@exec_matcher
	
	def initialize(options = {})   
		puts "-- Starting session (host=#{options[:host]} user=#{options[:user]} password=#{options[:password]})"
		@ssh_session = Net::SSH.start(options[:host], options[:user], :password => options[:password], :paranoid => Net::SSH::Verifiers::Null.new)
		@telnet_session = Net::SSH::Telnet.new("Session" => @ssh_session,"Prompt" => /(.*)(Neo>)/m,"Ors" => '',"Irs" => '') 
#		@exec_matcher = /(.*)(:)|(.*)(>)|(.*)(#)|(Address of remote host?)/m
		@exec_matcher = /(.*)(:)|(.*)(>)|(.*)(#)|(.*)(\?)/m
  end
	
	def exec(command)
		puts "-- [Sending] .."
		output = @telnet_session.cmd({ "String" => command, "Match" => @exec_matcher })
		puts "-- [exec] You entered \"" + output.split("\n")[0] + "\" and got \"" + output.split("\n")[1] + "\"" 
	end
	
	def exec!(command)
		puts "-- [Sending] .."
		output = @telnet_session.cmd({ "String" => command, "Match" => @exec_matcher })
		return output.split("\n")[1]
	end
	
	def exec_raw(command)
		puts "-- [Sending] .."
		output = @telnet_session.cmd({ "String" => command, "Match" => @exec_matcher })
		puts output
	end
	
	def exec_raw!(command)
		puts "-- [Sending] .."
		output = @telnet_session.cmd({ "String" => command, "Match" => @exec_matcher })
		return output
	end
end