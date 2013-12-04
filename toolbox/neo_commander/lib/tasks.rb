class WRTask < BaseTask
	def initialize(taskname, task_data, options = {})
		enforce_strict_task_definitions(self.class.name, task_data, options)
		@raketask = options["raketask"]
		@pattern = options["pattern"]
		@keyword = options["keyword"]
		@directory = options["directory"]		
		@task_url = options["url"]	
		super(taskname, task_data, options)
	end

	def is_valid
		p_d self.class.to_s + " is valid, i checked"
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
		#ENV['NS_PATTERN'] = File.join(@task_data['suite_root'], "/home/tasks/"+@pattern)
		
		if ENV['URL'].nil? && @task_url.nil?
			puts "FATAL: (ENV) 'URL' cannot be missing if not specified in the task profile YML" if @task_url.nil?
			exit(1)
		else
			ENV['BASEURL'] = ENV['URL'].nil? ? @task_url : ENV['URL']
		end		

		ENV['FILENAME'] = @pattern if ENV['FILE'].nil?	
		ENV['WR_DEBUG'] = 'on'
		ENV['WR_OWNER'] = 'NEOSUITE'		
		
		@app = Rake.application
		@app.init
		@app.add_import toolpath("webrobot", @task_data['toolbox_tools'], @task_data['tool_path_lookup'])+"/webrobot.rake"
		@app.load_imports

		p "-- Executing WRTask command: " + @raketask
		
		if @keepstdout 
			puts "Executing rake (STDOUT)"
			Rake.application[@raketask].reenable()
			Rake.application[@raketask].invoke()
			@output = "1 example, 0 failures"
			@exit_status = @task_data['test_exit_status_passed']
			#@output = "4 examples, 0 failures"
		else			
			begin
				redirect_webrobot_stdout{Rake.application[@raketask].reenable; Rake.application[@raketask].invoke}
			rescue Exception => e
				@exit_status = 
					case e.inspect
					when /Selenium::WebDriver::Error::NoSuchElementError/ then 
						puts "*** RESCUE ERROR: Selenium::WebDriver::Error::NoSuchElementError"
						@task_data['test_exit_status_noelement']
					when /Selenium::WebDriver::Error::WebDriverError/ then
						puts "*** RESCUE ERROR: Selenium::WebDriver::Error::WebDriverError"
						@task_data['test_exit_status_error']
					when /(Rake::Application)/, /(SystemExit)/ then
						puts "*** RESCUE ERROR: Rake::Application or SystemExit"						
						@task_data['test_exit_status_failed']
					else
						puts "*** RESCURE ERROR: " + e.inspect
						@task_data['test_exit_status_error']						
					end
					
			else				
				@exit_status = 
					case retrieve_webrobot_log
					when /0 failures/ then @task_data['test_exit_status_passed']
					when /0 examples, 0 failures/ then @task_data['test_exit_status_skipped']
					else @task_data['test_exit_status_failed']
				end
			ensure
				@output = retrieve_webrobot_log
				@examples = parse_logs_for_examples
				@output_short = "\n"+parse_logs_for_examples.join("\n")
				@output_short += "\n"+@examples.join("\n")+"\n"+@output.match(/Failures:(.*)Finished in/m)[1] if @exit_status == @task_data['test_exit_status_failed'] && !@output.nil?
				
				@matrix = {:FireFox => @exit_status}
				
				p @task_data['output_on'] == true ? @output : to_s 
				
			end
		end				
	end
	
	def parse_logs_for_examples
		found = []
		File.read("#{ENV["LOGS"]}#{@taskname}.txt").split("\n").each do |line|
			item = line.match(/^(\[TESTCASE\]).*/m)
			found.push item.to_s.gsub!('[TESTCASE] ', '') unless item.nil?
		end
		return found
	end
	
	def redirect_webrobot_stdout
		@orig_std_out = $stdout.clone
		@orig_std_err = $stderr.clone
		# $stdout = File.new( '/dev/null', 'w' )
		$stdout.reopen("#{ENV["LOGS"]}#{@taskname}.txt", "w")
		$stderr.reopen("#{ENV["LOGS"]}#{@taskname}.txt", "w")
		#$stdout.sync = true
		yield
	ensure
		$stdout.reopen(@orig_std_out)
		$stderr.reopen(@orig_std_err)
	end

	def retrieve_webrobot_log
		log = 
			File.open("#{ENV["LOGS"]}#{@taskname}.txt") do |f|
				f.read
			end
		return log
	end
		
	def to_s
		super
		s =  "        pattern:       #{@pattern}"						+ "\n"
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
		#full_filepath = File.join(File.dirname(__FILE__), "/home/tasks/#{@file}")
		full_filepath = "#{@task_data['suite_root']}/home/tasks/#{@file}"
		#puts "*********" + full_filepath
		@cmd = full_filepath + " " + @execute_args_ruby unless @execute_args_ruby == ""
		puts "executing RubyTask command: " + @cmd
		begin
			@output      = `ruby #{@cmd} 2>&1`
			@exit_status =  
				case @output
				when /PASSED/ then @task_data['test_exit_status_passed']
				when /FAILED/ then @task_data['test_exit_status_failed']
				else 
					case $?.exitstatus
					when 0 then @task_data['test_exit_status_passed']
					else @task_data['test_exit_status_failed']
					end
				end
		rescue => e
			@exit_status = @task_data['test_exit_status_error']
			p "-- ERROR: " + e.inspect
			p "   (in test:)"
			p to_s
		ensure
			#log_ruby_output(@output, @taskname)
			#log_output unless ENV['NC_DEBUG'].nil?
			p @task_data['output_on'] == true ? @output : to_s 
		end
	end
	
	def log_output
		puts "Dumping output to: #{@task_data['logs_dir']}#{@taskname}.txt" 
		File.open("#{ENV["LOGS"]}#{@taskname}.txt", "wb") do |file|
			file.write(output)
		end
	end
	
	def to_s
		super
		s =  "  ~     pattern:     #{@pattern}"							+ "\n"
		s += "  ~     keyword:     #{@keyword}"							+ "\n"
		s += "  ~     directory:   #{@directory}"
		puts s
	end
end