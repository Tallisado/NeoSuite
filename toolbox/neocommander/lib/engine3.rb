require 'yaml'
#require "rspec"

class YamlReader
	def initialize(file)
		if File.exist?(file)
			return YAML::load(File.read(file))
		else
			raise "-- ERROR: config YAML file doesn't exist: " + file
		end
	end
	
	def show
		puts @CONFIG.inspect
	end
end

class BaseTask
	#attr_accessor :result
	def initialize(taskname, options = {})
		@taskname = taskname
		@toolbox = options["toolbox"]#options[:toolbox].nil ? raise 'toolbox mandatory for task: ' + task : options[:toolbox]
		@failover = options["failover"]
		@tries = options["tries"].nil? ? 1 : options["tries"]
		@transpose = options["transpose"]
		@result = options["simulated_result"].nil? ? -1 : options["simulated_result"]
		@is_running = false
	end	
	
	def get_result()
		if !@is_running
			return @result.to_s
		else
			raise "cannot get result before finished"
		end
	end
	
	def run
	end
	
	def result_engine
		puts "-- [result_engine]"
		# @log_finished = false
		# while !@log_finished
			parse_log
		# end
	end
	
	def parse_log
		puts "-- [parse_log]"
	end
	
	def execute
		@is_running = true
		if @simulated_result != -1
			puts "--------------------------"
			puts "----- Execution: SIM -----"
			to_s
		else
			puts "--------------------------"
			puts "----- Execution: RUN -----"
			run
			result_engine
		end
		@is_running = false
	end
	
	def to_s
		puts "--------------------------"
		puts "BaseTask: #{@taskname}"
		puts "-> toolbox: #{@toolbox}"
		puts "-> failover: #{@failover}"
		puts "-> tries: #{@tries}"
	end
end

class RakeTask < BaseTask
	def initialize(taskname, options = {})
		@pattern = options["pattern"]
		@keyword = options["keyword"]
		@directory = options["directory"]		
		super(taskname, options)
	end
	
	def run
		puts "running task #{@taskname}"
	end
	
	def to_s
		super
		puts "RakeTask:"
		puts "-> pattern: #{@pattern}"
		puts "-> keyword: #{@keyword}"
		puts "-> directory: #{@directory}"
	end
end

class RubyTask < BaseTask
	def initialize(taskname, options = {})
		puts "add_task: #{taskname} " + options.to_s
		@rubyfile = options["file"]
		super(taskname, options)
	end
	
	def run
		puts "running task #{@taskname}"
	end
	
	def to_s
		super
		puts "RubyTask:"
		puts "-> rubyfile: #{@rubyfile}"
	end
end

class TaskChain
	attr_accessor :die
	
	def initialize
		@current_chain = 0
		@die = false
		@taskchain_array = Array.new
		@transpose_array = Array.new
	end
	
	def set_chainname(chainname)
		puts "chainname: #{chainname}"
		@chainname = chainname
	end
	
	def add_task(task_name, task_hash)
		if (task_hash["toolbox"] == "ruby")
			task = RubyTask.new(task_name, task_hash)
			@taskchain_array.push(task)
		end
	end
	
	def add_transpose(task_name, task_hash)
		puts "add transpose"
		if (task_hash["toolbox"] == "sshcommander")
			@transpose_array.push(RubyTask.new(task_name, task_hash))
		end
	end
	
	def apply_operational()
		# Gather output
		puts "result_from_last_test: "+ @taskchain_array[@current_chain].get_result()
		
		
		
		@current_chain = @current_chain+1
	end
	
	def run		
		@taskchain_array[@current_chain].execute
		apply_operational()
		
		if (@current_chain >= @taskchain_array.length) 
			@die = true
		end
	end
	
end


class RubySuite
	attr_accessor :selenium, :test_name, :CONFIG, :host, :port, :base_url, :browser, :debug_mode, :suite_root, :common, :platform, :onlylocal

  def initialize()
			
    @suite_root = File.expand_path "#{File.dirname(__FILE__)}/.."
    # -- loading global properties from yaml
    #@CONFIG = read_yaml_file(@suite_root+"/env.yaml")
    task_hash = YAML::load(File.read(Dir.pwd+"/sanity.yaml"))
		
		@chain = TaskChain.new()
		task_hash.each do |key, value|
			if key == "commander"
				@chain.set_chainname(value)
			else
				if key == "transpose"						
					#add to transpose
				else 
					@chain.add_task(key, value)
				end					
			end
		end
  end
	
	def start_suite 
		while !@chain.die
			@chain.run
		end
	end
	
	def define_operation_model
		@CONFIG
	end
end

@suite = RubySuite.new()
@suite.start_suite