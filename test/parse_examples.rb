
		found = []
		File.read("/mnt/wt/neosuite/home/workspace/2013_11_25_11.46.44/logs/neosuite_internal_sanity_single_test.txt").split("\n").each do |line|
			item = line.match(/^(\[TESTCASE\]).*/m)
			found.push item.to_s.gsub!('[TESTCASE] ', '') unless item.nil?
			#found.push item.to_s unless item.nil?
		end

		puts found