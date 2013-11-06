# -- usage: rake help

require "timeout"
require "fileutils"
require 'yaml'
require 'rake'

# -- first global
@suite_root							= File.expand_path "#{File.dirname(__FILE__)}"		
@suite_home							= "#{@suite_root}/home"
@suite_logs_dir					= "#{@suite_home}/logs/" + Time.now.strftime("%Y_%m_%d_%H.%M.%S")
@toolbox_tools					= ["neocommander", "webrobot", "sshcommander", "cmdcommander"]
@tool_path_lookup				= @toolbox_tools.each_with_object({}) { |v,h| h[v] = "#{@suite_root}/toolbox/#{v}" }
@neo_debug							= ENV["NC_DEBUG"].nil? ? false : true

################################
# NEO COMMANDER - Suite Global Commands
################################
def toolpath(toolname, toolbox_tools=@toolbox_tools, tool_path_lookup=@tool_path_lookup) 
	#return toolname.any? { |w| toolname =~ /#{w}/ } ? {raise "toolpath does not exist for #{toolname}"} : @tool_path_lookup[toolname.to_s]
	
	#puts "toolpath --------"
	#puts toolbox_tools
	x = toolbox_tools.any? { |w| toolname =~ /#{w}/ } ? tool_path_lookup[toolname.to_s] : nil
	if x.nil?
		puts toolbox_tools
		raise "toolpath does not exist for #{toolname}"		
	else
		return x
	end
end

def read_yaml_file(file)
#	begin
		if File.exist?(file)
			return YAML::load(File.read(file))
		end
		raise "-- ERROR: file doesn't exist: " + file
	# rescue
		# puts 'FUCK'
		# raise "[FATALERROR] The profile was incorrectly parsed (YAML) ~ Verify that the YAML is correct."
		# exit
	# end
end

################################
# STDOUT / STDERR / DEBUG
################################
def p(s) puts "-- #{Time.now.strftime('[%H:%M:%S]')} #{s}" end
#def p_d(s) puts "-D #{Time.now.strftime('[%H:%M:%S]')} #{s}" if @neo_debug == true end
def p_d(s) 
	if @neo_debug == false
		return
	else
		puts "-D #{Time.now.strftime('[%H:%M:%S]')} #{s}" 
	end
end

# -- global vars
task :default => [:run]
@chain                 	= []
@tasks_retried_counter 	= 0
@executed_tasks        	= 0
@current_task 				 	= 0
@task_hash							= read_yaml_file(@suite_root+"/home/profiles/tasklist.yaml")

# -- global needed in classes
@reports_dir           	= ENV["REPORTS"].nil? ? "/sado_reports" : ENV["REPORTS"]
@definition_yaml_hash		= read_yaml_file(toolpath("neocommander")+"/lib/definitions.yaml")

# -- the following vars control the behavior of running tests
#@task_types = {"ruby" => "RubyTask" , "WRTask"]

# -- global class data
@task_data = {
   'output_on'                => true,
   'test_retry'               => false,
   'test_exit_status_passed'  => "PASSED", 		#1 example, 0 failures
   'test_exit_status_failed'  => "FAILED",
   'test_exit_status_skipped' => "SKIPPED",
   'reports_dir'              => @reports_dir,
	 'definitions'							=> @definition_yaml_hash,
	 'toolbox_tools'						=> @toolbox_tools,
	 'tool_path_lookup'					=> @tool_path_lookup
}

# -- prepare reports_dir
def prepare_workspace_dir
   FileUtils.mkdir @suite_logs_dir
	 #FileUtils.cp(toolpath("webrobot")+'/webrobot.rake', @suite_home)
	 #FileUtils.rm_r(@task_data['reports_dir']) if File.directory?(@task_data['reports_dir'])
   #FileUtils.mkdir_p(@task_data['reports_dir'])
end

def prepare_taskchain
	@chain = TaskChain.new()
	@task_hash.each do |task_name, task_yaml_hash|
		if task_name == "commander"
			@chain.set_chainname(task_yaml_hash)
		elsif task_name == "transpose"
			@chain.add_transpose(task_name, @task_data, task_yaml_hash)
		else
			@chain.add_task(task_name, @task_data, task_yaml_hash)
		end
	end
end

def silence_stdout(filename)
	orig_std_out = STDOUT.clone
  # $stdout = File.new( '/dev/null', 'w' )
	$stdout.reopen("#{@suite_logs_dir}/#{filename}", "w")
	#$stdout.sync = true
  yield
ensure
  $stdout.reopen(orig_std_out)
end

def retrieve_stdout(filename)
	return (File.open("#{@suite_logs_dir}/#{filename}")).read
end

# -- run all tests
desc "-- run all tasks..."
task :run do
	puts "--- EXECUTING NEO COMMANDER ---"
	puts "--- [debug] : " + ((@neo_debug == false) ? "OFF" : "ON")
	puts "-------------------------------"

	#puts "running all the tasks"
	
	# -- first, let's setup/cleanup reports_dir
	prepare_workspace_dir
	
	# -- now, build the test toolchain from profile and task test files
	prepare_taskchain
	
	# -- let's run each test now
	@chain.execute_chain
end

# -- print tests
desc "-- print tasks and show how they are loaded..."
task :show do
	prepare_taskchain
	@chain.show_chain
end

desc "-- show usage of Neo Commander"
task :help do
    puts "\n-- usage: \n\n"
    puts "   rake help                                                     : print this message"
    puts "   rake run PROFILE=tasklist.yaml                                : this will run tasks based on the profile"
    puts "   rake show PROFILE=tasklist.yaml                               : this will print descriptions of your tasks, based on the profile"
    puts "   rake run PROFILE=tasklist.yaml REPORTS_DIR=</path/to/reports> : this will set default reports dir and run all tests\n\n\n\n"
    puts "   Eg:\n\n   rake PROFILE=tasklist.yaml REPORTS_DIR=</path/to/reports>\n\n\n"
    puts "   Sample profiles for your tasklist (loc: tests/some_test.rb):\n\n"
		puts "   deploy_biz1: { "
		puts "    toolbox: rubyfile,"
		puts "     file: \"some_file.rb\","
		puts "     failover: die,"
		puts "     retry: no,"
		puts "     paramlist: [a=1,y=string of win,someshit=1234]"
		puts "   }\n\n"
		puts "   Task Control:"
		puts "     [toolbox:] rubyfile|webrobot"
		
    puts "   Note 1:\n\n   Your test must end with 'test.rb' - otherwise Rake won't be able to find it, eg:\n"
}
    puts "   Note 1:\n\n   Your test must end with 'test.rb' - otherwise Rake won't be able to find it, eg:\n"
    puts "   tests/some_new_test.rb\n\n"
    puts "   Note 2:\n\n   Your test must define at least one keyword.\n\n"
end

# -- total by exit status
def all_by_exit_status(status)
   a = Array.new
   each { |t|
      a << t if t.exit_status == status
   }
   return a
end

# -- what do we do on exit ?
def clean_exit
	tasks_passed
	tests_passed     = all_by_exit_status(@task_data['test_exit_status_passed'])
   tests_failed     = all_by_exit_status(@task_data['test_exit_status_failed'])
   tests_skipped    = all_by_exit_status(@task_data['test_exit_status_skipped'])
   testcases_total  = all_testcase_in_tests
   testcases_passed = all_passing_testcase_in_tests
   verifications    = all_verifications_in_tests
   verifications_passed = all_passed_verifications_in_tests
   
   @task_data.merge!({'execution_time' => @execution_time, 'tests_passed' => tests_passed, 'tests_failed' => tests_failed, 'tests_skipped' => tests_skipped, 'testcases_total' => testcases_total, 'testcases_passed' => testcases_passed, 'verifications' => verifications, 'verifications_passed' => verifications_passed})
   
	 
	 #Publisher.new(@task_data).publish_reports
   
	 
	 
	 puts("\n==> DONE\n\n")
   puts(":: [SESSION]\n")
   puts("      -- reports prepared: #{@task_data['reports_dir']}\n")
   puts("      -- execution time  : #{@execution_time.to_s} secs\n")
   puts("      -- tests executed  : #{@executed_tasks.to_s}\n")
   puts("      -- tests passed    : #{tests_passed.length.to_s}\n")
   puts("      -- tests failed    : #{tests_failed.length.to_s}\n")
   puts("      -- tests skipped   : #{tests_skipped.length.to_s}\n")
   puts("      -- cases total     : #{testcases_total.to_s}\n")
   puts("      -- cases passed    : #{testcases_passed.to_s}\n")
   puts("      -- verifications   : #{verifications.to_s}\n")
   puts("      -- verify passed   : #{verifications_passed.to_s}\n")
   
   if @task_data['test_retry']
      puts("      -- tests re-tried  : #{@tests_retried_counter.to_s}\n")
   end
   if tests_failed.length > 0 || verifications_passed != verifications
      puts("\n\n==> STATUS: [ some tests failed - execution failed ]\n")
      exit(1)
   end
   exit(0)
end

#
# ::: Publisher [ creating report files ] :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
class Publisher
   def initialize(test_data)
      @task_data = test_data
      @tests_total     = @task_data['tests_passed'].length + @task_data['tests_failed'].length + @task_data['tests_skipped'].length
   end

   def write_file(file, data)
      File.open(file, 'w') {|f| f.write(data) }
   end

   def create_html_reports(status)
      output  = "<html><body>\n\nTests that #{status}:<br><br><table><tr><td>test</td><td>time</td></tr><tr></tr>\n"
      @task_data[status].each { |t|
         output += "<tr><td><a href='#{t.execute_class}.html'>#{t.execute_class}</a></td><td>#{t.execution_time}</td></tr>\n"
      }
      output += "</table></body></html>"
      write_file(@task_data['reports_dir'] + "/#{status}.html", output)
   end

   def publish_reports
      # -- remove reports dir if it exists, then create it
	  
      # -- create an xml file
      document  = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n"
      document += "<testsuites>\n"
      document += "   <testsuite successes='#{@task_data['tests_passed'].length}'"
      document += "   skipped='#{@task_data['tests_skipped'].length}' failures='#{@task_data['tests_failed'].length}'"
      document += "   time='#{@task_data['execution_time']}' name='FunctionalTestSuite' tests='#{@tests_total}' subtests='#{@task_data['testcases_total'].to_s}'>\n"
      if @task_data['tests_passed'].length > 0
         @task_data['tests_passed'].each  { |t|
            document += "   <testcase name='#{t.execute_class}' classname='#{@task_data['xml_report_class_name']}' time='#{t.execution_time}'>\n"
            document += "      <passed message='Test Passed'><![CDATA[\n\n#{t.output}\n\n]]>\n       </passed>\n"
            document += "   </testcase>\n"
         }
      end
      if @task_data['tests_failed'].length > 0
         @task_data['tests_failed'].each  { |t|
            document += "   <testcase name='#{t.execute_class}' classname='#{@task_data['xml_report_class_name']}' time='#{t.execution_time}'>\n"
            document += "      <error message='Test Failed'><![CDATA[\n\n#{t.output}\n\n]]>\n       </error>\n"
            document += "   </testcase>\n"
         }
      end
      if @task_data['tests_skipped'].length > 0
         @task_data['tests_skipped'].each  { |t|
            document += "   <testcase name='#{t.execute_class}' classname='#{@task_data['xml_report_class_name']}' time='#{t.execution_time}'>\n"
            document += "      <skipped message='Test Skipped'><![CDATA[\n\n#{t.output}\n\n]]>\n       </skipped>\n"
            document += "   </testcase>\n"
         }
      end
      document += "   </testsuite>\n"
      document += "</testsuites>\n"
      # -- write XML report
      write_file(@task_data['reports_dir'] + "/" + @task_data['xml_report_file_name'], document)
	  
      # -- write HTML report
      totals  = "<html><body>\n\nTests: #{@tests_total.to_s}<br>\n"
      totals += "Tests Passed: <a href='tests_passed.html'>#{@task_data['tests_passed'].length.to_s}</a><br>\n"
      totals += "Tests Failed: <a href='tests_failed.html'>#{@task_data['tests_failed'].length.to_s}</a><br>\n"
      totals += "Tests Skipped: <a href='tests_skipped.html'>#{@task_data['tests_skipped'].length.to_s}</a><br>\n"
      totals += "Testcases: #{@task_data['testcases_total'].to_s}<br>\n"
      totals += "Testcases Passed: #{@task_data['testcases_passed'].to_s}<br>\n"
      totals += "Execution time: #{@task_data['execution_time']}<br>\n</body></html>"
      write_file(@task_data['reports_dir'] + "/report.html", totals)
      # -- create individual html report files complete with test output
      create_html_reports("tests_passed")
      create_html_reports("tests_failed")
      create_html_reports("tests_skipped")
	  
	  # -- write an additional XML file that can be used by jenkins to plot the number of tests (total number of tests, ie:total subtests)
	  #<report>
	  #	<serie1>10</serie1>
	  #	<serie2>20</serie2>
	  #	<serie3>30</serie3>
	  #</report>

	  document  = "<webtester_plot>\n"
	  document += "<testcases>#{@task_data['testcases_total'].to_s}</testcases>\n"	  
	  document += "<t_passed>#{@task_data['testcases_passed'].to_s}</t_passed>\n"	  
	  document += "<verifications>#{@task_data['verifications'].to_s}</verifications>\n"
	  document += "<v_passed>#{@task_data['verifications_passed'].to_s}</v_passed>\n"
	  document += "</webtester_plot>\n"
	  write_file(@task_data['reports_dir'] + "/" + @task_data['xml_plot_file_name'], document)
   end
end

class TaskChain
	attr_accessor :die, :taskchain_array
	def initialize
		@current_chain_index = 0
		@chain_ended = false
		@chain_term = false
		@taskchain_array = Array.new
		@transpose_array = Array.new
	end
	
	def set_chainname(chainname)
		p_d "chainname: #{chainname}"
		p "-----chainname: #{chainname}"
		@chainname = chainname
	end
	
	def add_task(task_name, task_data, task_hash)
		if (task_hash["toolbox"] == "webrobot")
			@taskchain_array.push(WRTask.new(task_name, task_data, task_hash))
		elsif (task_hash["toolbox"] == "rubyfile")
			@taskchain_array.push(RubyTask.new(task_name, task_data, task_hash))
		elsif (task_hash["toolbox"] == "cmdline")
			p "no task defined : cmdline"
		end
	end
	
	def add_transpose(task_name, task_hash, task_data)
		p_d "add transpose"
		if (task_hash["toolbox"] == "wrtest")
			@transpose_array.push(RubyTask.new(task_name, task_data, task_hash))
		end
	end
	
	def apply_operational()
		# determine what happens based on all task information we have
		if @taskchain_array[@current_chain_index].exit_status.nil?
			raise "A TASK THAT SHOULD HAVE EXIT_STATUS WAS NULL!"
		end
		p_d "-Task(#{@taskchain_array[@current_chain_index].taskname}) exit_status: "+ @taskchain_array[@current_chain_index].exit_status
		p_d "-output: "+ @taskchain_array[@current_chain_index].output
		p_d "DETERMINING WHAT TO DO FOR OPERATIONAL"
		p_d "-- nothing"
		
		@current_chain_index = @current_chain_index+1
	end
	
	def show_chain
		@taskchain_array.each do |task|
			task.to_s
		end
	end
	
	def execute_chain	
		while (!@chain_ended)
			p_d "execute next link in chain"
			@taskchain_array[@current_chain_index].execute_base_task
			apply_operational()
			if (@current_chain_index >= @taskchain_array.length || @chain_term) 
				@chain_ended = true
			end
		end
	end	
end

class BaseTask
	attr_accessor :taskname, :exit_status, :output
	#attr_accessor :path, :execute_class, :execute_args, :keywords, :description, :author, :testcase_headers,
	#             :exit_status, :output, :execution_time, :test_data, :verification_error_count, :verification_count
	def initialize(taskname, task_data, options = {})
		
		@taskname 			= taskname
		@task_data      = task_data
		
		# definitions - base (mandatory)
		@toolbox 				= options['toolbox']#options[:toolbox].nil ? raise 'toolbox mandatory for task: ' + task : options[:toolbox]
		@failover 			= options['failover']
		
		# definitions - base (optional)
		@retry					= options['retry'].nil? ? false : true
		@transpose			= options['transpose']	
		@moveto					= options['moveto']
		
		@skipped				= false
		@transposed			= false
		@exit_status 		= options['simulated_result'].nil? ? nil : options['simulated_result']		
		@output					= ""
		@matrix					= {}
		@report_loc			= ""
		@tStart					= Time.new()
		@tEnd						= Time.new()
		
		
		#@transpose_count = 0
		#@skipped_count = 0
		#@exection_count = 0
		
		@execute_args_ruby 				= options['paramlist'].join(',') if !options['paramlist'].nil?
		@execute_args_webtester	 	= options['paramlist'].join(' ') if !options['paramlist'].nil?
		#puts @execute_args_hash
		 
		 
		@is_running 		= false	
		@execution_time = 0.0
		@timeout        = 144000 											# seconds (144000 is 4 hours)
	end

	# -- we should do something useful here
	# defined in the subclass
	def is_valid
	end	
	def execute_cmd
	end

	def execute_base_task
		# -- run the test if its valid
		if is_valid
			p_d "time to run"
			@tStart = Time.now
			p("running: [#{@taskname}] ")
			p("running: [#{@taskname}] ")
			
			begin
				@exit_status = "UNTOUCHED"
				status = Timeout::timeout(@timeout.to_i) {
					self.execute_cmd
				}
			rescue Timeout::Error => e
				@output << "\n\n[ TOTAL TEST TIME EXCEEDED ALLOWED DURATION AND WAS FORCED TO TERMINATE (#{@timeout.to_s}) ]"
				@exit_status = @task_data['test_exit_status_failed']
			ensure
				p @exit_status
				p "[++++++](OUTPUT INFORMATION):" if @task_data['output_on']
				p @output if @task_data['output_on']
				p "[------](OUTPUT)" if @task_data['output_on']
				p "[++++++](TESTCASE INFORMATION):" if @task_data['output_on']
				p "[------](TESTCASE)" if @task_data['output_on']
			end
			
			@tEnd = Time.now
		else
			# -- skipping this test
			@exit_status = @task_data['test_exit_status_skipped']
		end
	end

	def write_file(file, data)
		File.open(file, 'w') {|f| f.write(data) }
	end

	def write_log
		d = /^(.*\/).*/.match(@execute_class)[1]
		FileUtils.mkdir_p(@task_data['reports_dir'] + "/#{d}")	   
		write_file(@task_data['reports_dir'] + "/#{@execute_class}.html", "<html><body><pre>" + @output + "</pre><pre>:: [Total SubTests]: " + @testcase_headers.length.to_s + "</br>:: [TestCases]</br>---> " + @testcase_headers.join("</br>---> ") + "</pre></body></html>")
	end
	
	def enforce_strict_task_definitions(task_type, task_data, options_hash)	
		options_hash.each do |key, value|
			optional = task_data['definitions']['RubyTask'].gsub(' ','').split(',').keep_if { |v| v =~ /^(~).*/ }
			mandatory = task_data['definitions']['RubyTask'].gsub(' ','').split(',').keep_if { |v| v =~ /^([^~]).*/ }
			
			p_d "mandatory [#{task_type}] :: " + mandatory.to_s
			mandatory.each do |mandatory_value| 
				if options_hash.keys.any? { |w| mandatory_value =~ /#{w}/ }
					#puts "found #{mandatory_value} in above list"
				else
					#puts "NOT found #{mandatory_value} in above list"
					raise "mandatory key: #{optional_value} was not found in the list:" + mandatory
				end
			end
			
			p_d "optional [#{task_type}] :: " + optional.to_s
			optional.each do |optional_value| 
				if options_hash.keys.any? { |w| optional_value =~ /#{w}/ }
					#puts "~~~~found #{optional_value} in above list"
				else
					#puts "~~~~NOT found #{optional_value} in above list"
					#raise "optional key: #{optional_value} was not found in the list:" + mandatory
				end
			end
		end
	end
	
	def to_s
		s = "\n ------------------------------------\n"
		s += " #{@taskname} [#{self.class}]"				+ "\n"
#		s += "        taskdata:     #{@task_data}"			+ "\n"
		s += "        toolbox:      #{@toolbox}"				+ "\n"
		s += "        failover:     #{@failover}"				+ "\n"
		s += "        retry:        #{@retry}"					+ "\n"
		s += "        transpose:    #{@transpose}"			+ "\n"
		s += "        moveto:       #{@moveto}"					+ "\n"
		s += "        paramlist:    #{@paramlist}"			+ "\n"
		s += "        skipped:      #{@skipped.to_s}"		+ "\n"
		s += "        transposed:   #{@transposed.to_s}"+ "\n"
		s += "        exit_status:  #{@exit_status}"		+ "\n"
		s += "        matrix:       #{@matrix}"					+ "\n"
		s += "        exec time:    #{@execution_time}"	+ "\n"
		s += "        output:       #{@output}"
		puts s
	end
end
	 
class WRTask < BaseTask
	def initialize(taskname, task_data, options = {})
		enforce_strict_task_definitions(self.class.name, task_data, options)
		@raketask = options["raketask"]
		@pattern = options["pattern"]
		@keyword = options["keyword"]
		@directory = options["directory"]		
		super(taskname, task_data, options)
	end

	def is_valid
		puts self.class.to_s + " is valid, i checked"
		return true
	end
	
	# WRTask EXE
	# rake custom:domaudit[url,username,userpass]  # Run RSpec code examples
	# rake local:headed                            # Setup fixtures for HEADED and execute the tests
	# rake local:headless                          # Setup the fixtures for running HEADLESS and execute the tests
	# rake local:nofixtures:headed                 # SKIP the fixtures for running HEADED and execute the tests
	# rake local:nofixtures:headless               # SKIP the fixtures for running HEADLESS and execute the tests
	# rake spec:sauce                              # Default: run tests against the selenium driver on the local machine (components should be currently running)
	def execute_cmd	
		#rake_output = toolpath("webrobot") + "./results/#{@uuid}_stdout.tmp"
		@keepstdout = false
		ENV['FILE'] = "somefile"
		ENV['WR_DEBUG'] = 'on'
		
		puts "BREAK IT OFF"
		app = Rake.application
		app.init
		app.add_import toolpath("webrobot", @task_data['toolbox_tools'], @task_data['tool_path_lookup'])+"/webrobot.rake"
		app.load_imports

		puts "executing WRTask command: " + @raketask
		
		if @keepstdout 
			puts "Executing rake (STDOUT)"
			Rake.application['for:real'].invoke()
			@output = "1 example, 0 failures"
			#@output = "4 examples, 0 failures"
		else 
			puts "Executing rake (STDOUT REDIR)"
			silence_stdout(@taskname+".wrlog") {Rake.application[@raketask].invoke() }
			@output = retrieve_stdout(@taskname+".wrlog")
		end

		@exit_status = case @output
			when /0 failures/ then @task_data['test_exit_status_passed']
			else @task_data['test_exit_status_failed']
		end	
		@matrix = {}
	end
	
	def to_s
		super
		s = "\n ------------------------------------\n"
		s += "        pattern:       #{@pattern}"						+ "\n"
		s += "        keyword:       #{@keyword}"						+ "\n"
		s += "        directory:     #{@directory}"				
		puts s
	end
end

class RubyTask < BaseTask
	def initialize(taskname, task_data, options = {})
		enforce_strict_task_definitions(self.class.name, task_data, options)
		@file = options["file"]
		@pattern = options["pattern"]
		@keyword = options["keyword"]
		@directory = options["directory"]		
		super(taskname, task_data, options)
	end
	
	def is_valid
		puts self.class.to_s + " is valid, i checked"
		return true
	end
	
	# RubyTask EXE
	def execute_cmd
		@cmd = "#{@file} " + @execute_args_ruby unless @execute_args_ruby == ""
		puts "executing RubyTask command: " + @cmd
		# begin
			# @output      = `ruby #{@cmd} 2>&1`
			# # @exit_status = case @output
				# when /PASSED/ then @test_data['test_exit_status_passed']
				# when /FAILED/ then @test_data['test_exit_status_failed']
				# else @test_data['test_exit_status_failed']
			# end
			 # t.validate
			 # # -- do we run test more than once if it failed first time ?
			 # if (t.exit_status == @test_data['test_exit_status_failed']) and (@test_data['test_retry'])
					# puts("-- first attempt failed, will try again...")
					# t.validate
					# @tests_retried_counter += 1
			 # end
		# rescue => e
			 # puts "-- ERROR: " + e.inspect
			 # puts "   (in test: #{t.execute_class})"
		# ensure
			 # @executed_tests += 1
		# end
	end
	
	def to_s
		super
		s =  "  ~     pattern: #{@pattern}"							+ "\n"
		s += "  ~     keyword: #{@keyword}"							+ "\n"
		s += "  ~     directory: #{@directory}"
		puts s
	end
end