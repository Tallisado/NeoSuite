require 'yaml'
class YamlReader
	@CONFIG	
	def initialize(file)
		if File.exist?(file)
			@CONFIG = YAML::load(File.read(file))
		else
			raise "-- ERROR: config YAML file doesn't exist: " + file
		end
	end
	
	def get_setup
	end
	
	def show
		puts @CONFIG
	end	
end

puts Dir.pwd
puts File.exist?(Dir.pwd+"/sanity.yaml")
yamlr = YamlReader.new(Dir.pwd+"/sanity.yaml")
yamlr.show

