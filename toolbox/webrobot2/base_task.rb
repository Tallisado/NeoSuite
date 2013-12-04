#!/usr/bin/env ruby


#flags = Foo::BAR | Foo::BAZ # flags = 3
module TaskType
  WEBROBOT 			= 1
  CMDLINE 			= 2
  SSHCOMMANDER 	= 4
end

module TaskStatus
	IDLE						= 0
  PASSED 					= 1
  FAILED	 				= 2
  SKIPPED					= 4
  SUITE_ERROR			= 8
	WR_NOELEMENT		= 16
	RETRY						= 128
end

module TaskState
	TRANSPOSED						= 0
  SKIPPED								= 1
end

def p(s) puts "-- #{Time.now.strftime('[%H:%M:%S]')} #{s}" end
def p_d(s) puts "-D #{Time.now.strftime('[%H:%M:%S]')} #{s}" if ENV["NC_DEBUG"] end

class BaseTask
    attr_accessor :suite, :passed, :script
		
		TASK_SUITE_ERROR_RETRY		 = 5
		TASK_TIMEOUT		 					 = 144_000 # ms (144000 is 4 hours)
		
		
    def initialize(options)
		puts options.inspect
			@name			 			= options.fetch(:name, 'unknown') 
			@task_data      = options.fetch(:data, nil)
			@toolbox 				= options.fetch(:toolbox_flags, 0)
			@failover 			= options.fetch(:failover, false)
			@retry 					= options.fetch(:retry, 0)
			@transpose			= options.fetch(:transpose, nil)
			@moveto    			= options.fetch(:moveto, nil)			
			@state				  = TaskStatus::IDLE	

			@description		= ""
			@keywords       = ""
			@author         = ""
			@execute_args   = ""
			@path           = options.fetch("path", nil)
			@execute_class  = ""
			@filename       = options.fetch("filename", nil)
			
			
			@examples  			= []
			@matrix					= {}
			@stdout					= ""
			@stdout_short		= ""
			
			@tStart					= Time.new()
			@tEnd						= Time.new()		

			@selenium 			= nil
			
			@param_list 		= options['paramlist'].join(',') unless options['paramlist'].nil?	
			
			@script 					= File.open("#{@path}/#{@filename}", 'rb') {|f| f.read }
			#@tool						= Headless.new({})
			
			@runtime      	= 0.0
    end

		def run
			puts 'RUN'
			headless = Headless.new
			headless.start

			driver = Selenium::WebDriver.for :firefox
			driver.navigate.to 'http://google.com'
			puts driver.title

			headless.destroy
			
			#run_task { @script }
		end

    # -- test begins
    def run_task(&block)
        yield @tool
    end    
		
		# -- test begins
    def run_task1(&block)
       begin
        setup
        yield @tool
      rescue => e
				p $!
			ensure
				teardown
				#@tool.clean_exit(@passed)
			end
    end
		
    def setup
       p "\n:: [SETUP]\n"
    end
    def teardown
       p "\n:: [TEARDOWN]\n"
    end
		
		def to_s
			p "to string"
			puts @path
			puts @script
		end
end
