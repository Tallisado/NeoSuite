class BaseTask
	attr_accessor :taskname, :exit_status, :output, :task_execution_time, :test_data, :examples
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
		@output_short		= ""
		@examples  			= []
		@matrix					= {}
		@report_loc			= ""
		@tStart					= Time.new()
		@tEnd						= Time.new()		
		
		#@transpose_count = 0
		#@skipped_count = 0
		#@exection_count = 0
		
		@execute_args_ruby 				= options['paramlist'].join(',') unless options['paramlist'].nil?
		@execute_args_webtester	 	= options['paramlist'].join(' ') unless options['paramlist'].nil?
		#puts @execute_args_hash		 
		 
		@is_running 					= false	
		@task_execution_time 	= 0.0
		@timeout        			= 144_000 # ms (144000 is 4 hours)
	end

	# -- we should do something useful here
	# defined in the subclass
	def is_valid; end	
	def execute_cmd; 	end

	def execute_base_task
		# -- run the test if its valid
		if is_valid
			p_d "time to run"
			@tStart = Time.now
			p("running: [#{@taskname}] ")
			self.execute_cmd
			@tEnd = Time.now
		else
			# -- skipping this test
			@exit_status = @task_data['test_exit_status_skipped']
		end
	end

	def write_file(file, data)
		File.open(file, 'w') {|f| f.write(data) }
	end

	# def write_log
		# d = /^(.*\/).*/.match(@execute_class)[1]
		# FileUtils.mkdir_p(@task_data['reports_dir'] + "/#{d}")	   
		# write_file(@task_data['reports_dir'] + "/#{@execute_class}.html", "<html><body><pre>" + @output + "</pre><pre>:: [Total SubTests]: " + @testcase_headers.length.to_s + "</br>:: [TestCases]</br>---> " + @testcase_headers.join("</br>---> ") + "</pre></body></html>")
	# end
	
	def enforce_strict_task_definitions(task_type, task_data, options_hash)	
		options_hash.each do |key, value|
			optional = task_data['definitions'][task_type].gsub(' ','').split(',').keep_if { |v| v =~ /^(~).*/ }
			mandatory = task_data['definitions'][task_type].gsub(' ','').split(',').keep_if { |v| v =~ /^([^~]).*/ }
			
			p_d "mandatory [#{task_type}] :: " + mandatory.to_s
			mandatory.each do |mandatory_value| 
				if options_hash.keys.any? { |w| mandatory_value =~ /#{w}/ }
					#puts "found #{mandatory_value} in above list"
				else
					#puts "NOT found #{mandatory_value} in above list"
					raise "mandatory key: #{mandatory_value} was not found in the list:" + mandatory.to_s
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
		s += "        exec time:    #{@task_execution_time}"	+ "\n"
		s += "        output_short: #{@output_short}"	+ "\n"
		puts s
	end
end