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
		ENV['FILE'] = File.join(@task_data['suite_root'], "/home/tasks/"+@pattern)
		ENV['WR_DEBUG'] = 'on'
		ENV['WR_OWNER'] = 'NEOSUITE'
		
		@app = Rake.application
		@app.init
		@app.add_import toolpath("webrobot", @task_data['toolbox_tools'], @task_data['tool_path_lookup'])+"/webrobot.rake"
		@app.load_imports

		p "-- Executing WRTask command: " + @raketask
		
		if @keepstdout 
			puts "Executing rake (STDOUT)"
			Rake.application['for:real'].invoke()
			@output = "1 example, 0 failures"
			#@output = "4 examples, 0 failures"
		else			
			begin
				redirect_webrobot_stdout{Rake.application[@raketask].invoke() }
				@output = retrieve_webrobot_log
				#find out matrix from cloud if needed
				@matrix = {}
				@exit_status = 
					case @output
					when /0 failures/ then @task_data['test_exit_status_passed']
					when /0 examples, 0 failures/ then @task_data['test_exit_status_skipped']
					else @task_data['test_exit_status_failed']
				end
				#rescue Rake::ApplicationAbortedException, SystemExit => e
				rescue Rake::Application, SystemExit => e
					@output = retrieve_webrobot_log
					@exit_status = @task_data['test_exit_status_failed']			
				#rescue Selenium::WebDriver::Error::WebDriverError => e ------- this is throwing the error  NameError: uninitialized constant WRTask::Selenium
				rescue => e
					@output = retrieve_webrobot_log
					@exit_status = @task_data['test_exit_status_error']
					p "-- ERROR -----: " + e.inspect
					p "   (in test:)"
			ensure
				@examples = parse_logs_for_examples
				if @exit_status == @task_data['test_exit_status_failed']				
					@output_short = "\n" + @examples.join("\n") + "\n" + @output.match(/Failures:(.*)Finished in/m)[1]
				else
					@output_short = "\n" + parse_logs_for_examples.join("\n")
				end
				@matrix = {}
				p @task_data['output_on'] == true ? @output : to_s 
			end
		end				
	end
	
	def parse_logs_for_examples
		found = []
		File.read("#{@task_data['logs_dir']}#{@taskname}.txt").split("\n").each do |line|
			item = line.match(/^(  should)[a-zA-Z ]*/m)
			found.push item.to_s unless item.nil?
		end
		return found
	end
	
	def redirect_webrobot_stdout
		orig_std_out = STDOUT.clone
		# $stdout = File.new( '/dev/null', 'w' )
		$stdout.reopen("#{@task_data['logs_dir']}#{@taskname}.txt", "w")
		#$stdout.sync = true
		yield
	ensure
		$stdout.reopen(orig_std_out)
	end

	def retrieve_webrobot_log
		return (File.open("#{@task_data['logs_dir']}#{@taskname}.txt")).read
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
		full_filepath = File.join(File.dirname(__FILE__), "/home/tasks/#{@file}")
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
			log_output unless ENV['NC_DEBUG'].nil?
		end
	end
	
	def log_output
		puts "Dumping output to: #{@task_data['logs_dir']}#{@taskname}.txt" 
		File.open("#{@task_data['logs_dir']}#{@taskname}.txt", "wb") do |file|
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