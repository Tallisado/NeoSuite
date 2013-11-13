		def parse_for_passing_examples
		found = []
		File.read('test_webrobot.txt').split("\n").each do |line|
			item = line.match(/^(  should)[a-zA-Z ]*/m)
			found.push item.to_s unless item.nil?
		end
		return found
	end

a = parse_for_passing_examples

puts a
