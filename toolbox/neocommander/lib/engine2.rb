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
	#attr_accessor :selenium
	def initialize(taskname, options = {})
		@taskname = taskname
		@toolbox = options[:toolbox]#options[:toolbox].nil ? raise 'toolbox mandatory for task: ' + task : options[:toolbox]
		@failover = options[:failover]
		@tries = options[:tries]
	end
	
end

class RakeTask < BaseTask
	def initialize(taskname, options = {})
		@pattern = options[:pattern]
		@keyword = options[:keyword]
		@directory = options[:directory]		
		super(taskname, options)
	end
end


class RubySuite
   attr_accessor :selenium, :test_name, :CONFIG, :host, :port, :base_url, :browser, :debug_mode, :suite_root, :common, :platform, :onlylocal

   def initialize(options)
      @suite_root = File.expand_path "#{File.dirname(__FILE__)}/.."
      # -- loading global properties from yaml
      #@CONFIG = read_yaml_file(@suite_root+"/env.yaml")
      tasklist_hash = YAML::load(File.read(Dir.pwd+"/sanity.yaml"))

			# tasklist_array = []
			# tasklist_yaml.each_key do |task_yaml|
				# task = {}
				# taskname = e
				# hash.each_key do |e|
				# puts e
			# end
map = tasklist_hash.inject({}) {|h, (k,v)| h.update({k.upcase => v})}
p map
			#@CONFIG[*@CONFIG.map{|key,value| [key.upcase, value]}.flatten]
			#puts @CONFIG.sort.map {|k,v| [k.to_s + "----"] + v}
			# @CONFIG.keys.sort.each do |key|
				# puts key
				# @CONFIG[key].each { |val| puts val }
			# end
			
			
			#@CONFIG.show
			
      # -- setting env for a given test
      #set_test_name(@CONFIG['commander_profile_name'])
      # -- do init
			#define_operation_model
      #do_init
   end
	 
	def define_operation_model
		@CONFIG
	end
end

@suite = RubySuite.new(:a => 1)