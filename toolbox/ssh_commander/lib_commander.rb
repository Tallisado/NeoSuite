require 'net/ssh'
require 'net/ssh/telnet'

module RubyTaskSingletonMethods
	def arg_available?
		!!self.ARGV
	end
	def getArgList
		self.ARGV
	end
end

class ShellCommander
  attr_accessor :telnet_session
	
	DEFAULT_TELNET_WAITFOR_TIMEOUT  = 15000
	
	@ssh_session
	@telnet_session
	@exec_matcher = /(.*)(:)|(.*)(>)|(.*)(#)|(.*)(\?)/m
	
	def initialize 
		puts "ShellCommander instance created .."
		@exec_matcher = /(.*)(:)|(.*)(>)|(.*)(#)|(.*)(\?)/m
  end

	def is_open?
		!!@telnet_session
	end
	
	def open_telnet(options = {})   		
		puts "-- Starting session (host=#{options[:host]} user=#{options[:user]} password=#{options[:password]})"
		begin
			@ssh_session = Net::SSH.start(options[:host], options[:user], :password => options[:password], :paranoid => Net::SSH::Verifiers::Null.new)
			@telnet_session = Net::SSH::Telnet.new("Session" => @ssh_session,"Prompt" => /(.*)(Neo>)/m,"Ors" => '',"Irs" => '') 	
			puts "no error in open_telnet"
		rescue Errno::EHOSTUNREACH => e
			sleep 5
			@telnet_session = nil
			puts "telnet failed to connect"
		end
		
  end
	
	def open_telnet!(options = {}) 
    start_time = Time.now
		@retry_timeout = options.fetch(:retry_timeout, DEFAULT_TELNET_WAITFOR_TIMEOUT) 
		puts "-- Telnet retry connection : " + @retry_timeout.to_s
    begin
			puts "trying to open a connection"
      open_telnet(options)
			raise "ShellCommander:Connect has timed out" if (Time.now-start_time)>=@retry_timeout
    end while !is_open?
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
	
	# def self.included(base)
    # base.extend RubyTaskSingletonMethods
  # end
	
	def self.args?
		!!ARGV
	end
	def self.get_arg_string
		ARGV.to_s.gsub!(/[\[\]"]/, '')
	end
	def self.get_arg_list
		ARGV.to_s.gsub!(/[\[\]"]/, '').split(',')
	end
	def self.get_arg(name)
		begin
			ARGV.to_s.gsub!(/[\[\]"]/, '').split(',').find { |e| /#{name}/ =~ e }.split('=')[1]
		rescue 
			nil
		end
	end
end

## notes
## this will loop until either the retry is hit, or connection established - timeout error is : ShellCommander:Connect has timed out (RuntimeError)
###sc.open_telnet!(:host => "10.10.9.165", :user => "admin", :password => "password", :retry_timeout => 10)
## this will execute once, and then go to the next line -- even if fail
###sc.open_telnet(:host => "10.10.9.165", :user => "admin", :password => "password")
## you can check to see if the above line connected using 'sc.isconnected?', which returns a boolean