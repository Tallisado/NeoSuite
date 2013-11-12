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
			return YAML::load(File.read(file)) if File.exist?(file)
		raise "-- ERROR: file doesn't exist: " + file
	# rescue
		# puts 'YAML failed and was caught in rescue'
		# raise "[FATALERROR] The profile was incorrectly parsed (YAML) ~ Verify that the YAML is correct."
		# exit
	# end
end