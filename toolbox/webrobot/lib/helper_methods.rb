module HelperMethods
  def wr_p(text)
    puts "["+Time.now.to_s+"] " + text.to_s
  end
  def wr_d(text)
		if ENV['WR_DEBUG']
			puts "["+Time.now.to_s+"] " + text.to_s
		end
  end
	def wr_tag(text, tag)
			puts "["+tag.to_s+"] " + text.to_s
  end
	def read_yaml_file(file)
	#	begin
			if File.exist?(file)
				return YAML::load(File.read(file))
			end
			raise "-- ERROR: file doesn't exist: " + file
		# rescue
			# puts 'YAML failed and was caught in rescue'
			# raise "[FATALERROR] The profile was incorrectly parsed (YAML) ~ Verify that the YAML is correct."
			# exit
		# end
	end
end