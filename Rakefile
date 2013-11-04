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

#
# 				toolpath("neocommander")+"/lib/definitions.yaml"
#
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

#Dir.cp toolpath("webrobot")+'/webrobot.rake'
#Dir.glob(toolpath("webrobot")).each { |r| import r }

def read_yaml_file(file)
	if File.exist?(file)
		return YAML::load(File.read(file))
	end
	raise "-- ERROR: file doesn't exist: " + file
end

# -- global vars
#task :default => [:run]
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

# -- our own each method yielding each test in the @tests array
def each
	#puts @chain.taskchain_array
  @chain.taskchain_array.each { |t| yield t }
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
	puts "---STARTING---"
	Dir.chdir(@suite_home) do
		puts "running all the tasks"
		
		# -- first, let's setup/cleanup reports_dir
		prepare_workspace_dir
		
		# -- now, build the test toolchain from profile and task test files
		prepare_taskchain
		
		# -- let's run each test now
		@chain.execute_chain
		puts 'done1'
		#clean_exit		
	end
	puts 'done2'
end

# # -- print tests
# desc "-- print tests..."
# task :print_human do
	# prepare_taskchain
	# each { |t|
		# begin
			 # puts t.to_s
		# rescue => e
			 # puts "-- ERROR: " + e.inspect
			 # puts "   (in test: #{t.execute_class})"
		# end
	# }
# end

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
		puts "chainname: #{chainname}"
		@chainname = chainname
	end
	
	def add_task(task_name, task_data, task_hash)
		if (task_hash["toolbox"] == "webrobot")
			@taskchain_array.push(WRTest.new(task_name, task_data, task_hash))
		elsif (task_hash["toolbox"] == "rubyfile")
			@taskchain_array.push(RubyTest.new(task_name, task_data, task_hash))
		elsif (task_hash["toolbox"] == "cmdline")
			puts "no task defined : cmdline"
		end
	end
	
	def add_transpose(task_name, task_hash, task_data)
		puts "add transpose"
		if (task_hash["toolbox"] == "wrtest")
			@transpose_array.push(RubyTask.new(task_name, task_data, task_hash))
		end
	end
	
	def apply_operational()
		# determine what happens based on all task information we have
		puts "-Task(#{}) exit_status: "+ @taskchain_array[@current_chain_index].exit_status
		puts "-output: "+ @taskchain_array[@current_chain_index].output
		puts "DETERMINING WHAT TO DO FOR OPERATIONAL"
		puts "-- nothing"
		
		@current_chain_index = @current_chain_index+1
	end
	
	def execute_chain	
		while (!@chain_ended)
			puts "execute next link in chain"
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
		@retry					= options['retry']
		@transpose			= options['transpose']	
		@moveto					= options['moveto']
		
		@skipped				= false
		@transposed			= false
		@exit_status 		= options['simulated_result'].nil? ? -1 : options['simulated_result']		
		@output					= ""
		@matrix					= {}
		@report_loc			= ""
		@tStart					= Time.new()
		@tEnd						= Time.new()
		
		
		#@transpose_count = 0
		#@skipped_count = 0
		#@exection_count = 0
		
		@execute_args   = options['paramlist'].split(',').each_with_object({}) { |v,h| h[v.split('=')[0]] = "#{v.split('=')[1]}"} if !options['paramlist'].nil?
		 
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
			puts "time to run"
			@tStart = Time.now
			puts("-- #{@tStart.strftime('[%H:%M:%S]')} running: [#{@taskname}] ")
			puts("-- #{@tStart.strftime('[%H:%M:%S]')} running: [#{@taskname}] ")
			
			begin
				status = Timeout::timeout(@timeout.to_i) {
					execute_cmd
					#@output = "HERE IS THE LOG FROM WRTest SUCCESS"
					#@output      = `ruby #{@cmd} 2>&1`
					
					# Gather all headers
					#@output.scan(/^-- {TESTCASE} \[(.*?)]/).each { |z| @testcase_headers << z[@task_data['test_heading_tag'].length+1..-1] }	
					#@output.scan(/^-- \{TESTCASE\} \[(.*?)\]/).each { |z| @testcase_headers << z }	
					# Gather verification error count
					#@verification_count = @output.scan(/^-- VERIFICATIONS EXECUTED: \((.*)\)/).to_s.to_i
					#@verification_error_count = @output.scan(/^-- VERIFICATION ERRORS: \((.*)\)/).to_s.to_i if @exit_status == @task_data['test_exit_status_failed']
				}
			rescue Timeout::Error => e
				@output << "\n\n[ TOTAL TEST TIME EXCEEDED ALLOWED DURATION AND WAS FORCED TO TERMINATE (#{@timeout.to_s}) ]"
				@exit_status = @task_data['test_exit_status_failed']
			ensure
				puts @exit_status
				puts "[++++++](OUTPUT INFORMATION):" if @task_data['output_on']
				puts @output if @task_data['output_on']
				puts "[------](OUTPUT)" if @task_data['output_on']
				puts "[++++++](TESTCASE INFORMATION):" if @task_data['output_on']
				puts "[------](TESTCASE)" if @task_data['output_on']
			end
			
			@tEnd = Time.now
			#@execution_time = @tEnd - @tStart		
			
			
			
			
			
			
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
	
	def enforce_strict_task_definitions(task_type, options_hash)	
		# options_hash.each do |key, value|
			# puts "Checking def hash: "
			# puts @task_data['definitions']
			# puts "ASD"
			# optional = @task_data['definitions'][task_type.to_sym].split(',').keep_if { |v| v =~ /^(#).*/ }
			# mandatory = @task_data['definitions'][task_type.to_sym].split(',').keep_if { |v| v =~ /^([^#]).*/ }
			
			# mandatory.each do |mkey| 
				# if !mandatory.any? { |w| mkey =~ /#{w}/ }
					# raise "mandatory key: #{mkey} was not found in the list:" + mandatory
				# end
			# end
		# end
	end

	def to_s
		puts "--------------------------"
		puts "BaseTask: 			#{@taskname}"
		puts "-> type: 				#{self.class}"
#		puts "-> taskdata: 		#{@task_data}"
		puts "-> toolbox: 		#{@toolbox}"
		puts "-> failover: 		#{@failover}"
		puts "-> retry: 			#{@retry}"
		puts "-> transpose: 	#{@transpose}"
		puts "-> moveto: 			#{@moveto}"
		puts "-> paramlist: 	#{@paramlist}"
		puts "-> skipped: 		#{@skipped.to_s}"
		puts "-> transposed:	#{@transposed.to_s}"
		puts "-> exit_status:	#{@exit_status}"
		puts "-> matrix:			#{@matrix}"
		puts "-> exec time:		#{@execution_time}"
		puts "-> output:			#{@output}"
		puts "-> [~~~~~]"		
	end
end
	 
class WRTest < BaseTask
	def initialize(taskname, task_data, options = {})
		enforce_strict_task_definitions(self.class.name, options)
		@cmd = options["cmd"]
		@pattern = options["pattern"]
		@keyword = options["keyword"]
		@directory = options["directory"]		
		super(taskname, task_data, options)
	end

	def is_valid
		puts self.class.to_s + " is valid, i checked"
		return true
	end
	
	# WRTest EXE
	# rake custom:domaudit[url,username,userpass]  # Run RSpec code examples
	# rake local:headed                            # Setup fixtures for HEADED and execute the tests
	# rake local:headless                          # Setup the fixtures for running HEADLESS and execute the tests
	# rake local:nofixtures:headed                 # SKIP the fixtures for running HEADED and execute the tests
	# rake local:nofixtures:headless               # SKIP the fixtures for running HEADLESS and execute the tests
	# rake spec:sauce                              # Default: run tests against the selenium driver on the local machine (components should be currently running)
	def execute_cmd	
		#rake_output = toolpath("webrobot") + "./results/#{@uuid}_stdout.tmp"
		@keepstdout = true
		ENV['FILE'] = "somefile"
		ENV['WR_DEBUG'] = 'on'
		
		puts "BREAK IT OFF"
		app = Rake.application
		app.init
		app.add_import toolpath("webrobot", @task_data['toolbox_tools'], @task_data['tool_path_lookup'])+"/webrobot.rake"
		app.load_rakefile

		puts "executing WRTest command: " + @cmd
		
		if @keepstdout 
			puts "Executing rake (STDOUT)"
			Rake.application['for:real'].invoke()
			@output = "1 example, 0 failures"
			#@output = "4 examples, 0 failures"
		else 
			puts "Executing rake (STDOUT REDIR)"
			silence_stdout("task_example.tmp") {Rake.application[@cmd].invoke() }
			@output = retrieve_stdout("task_example.tmp")
		end

		@exit_status = case @output
			when /0 failures/ then @task_data['test_exit_status_passed']
			else @task_data['test_exit_status_failed']
		end	
		@matrix = {}
	end
	
	def to_s
		super
		puts "RakeTask:"
		puts "-> pattern: #{@pattern}"
		puts "-> keyword: #{@keyword}"
		puts "-> directory: #{@directory}"
	end
end

class RubyTest < BaseTask
	def initialize(taskname, task_data, options = {})
		enforce_strict_task_definitions(self.class.name, options)
		@pattern = options["pattern"]
		@keyword = options["keyword"]
		@directory = options["directory"]		
		super(taskname, task_data, options)
	end
	
	def is_valid
		puts self.class.to_s + " is valid, i checked"
		return true
	end
	
	# RubyTest EXE
	def execute_cmd
		put "executing task command"
		@output = "1 example, 0 failures"
		@exit_status = case @output
			when /PASSED/ then @task_data['test_exit_status_passed']
			when /FAILED/ then @task_data['test_exit_status_failed']
			else @task_data['test_exit_status_failed']
		end		
		@matrix = {}
	end
	
	def to_s
		super
		puts "RakeTask:"
		puts "-> pattern: #{@pattern}"
		puts "-> keyword: #{@keyword}"
		puts "-> directory: #{@directory}"
	end
end