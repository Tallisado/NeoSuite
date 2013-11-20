case '#<SystemExit: /usr/bin/ruby1.9.1 -S rspec /mnt/wt/neosuite/home/tasks/dryrun_two_webrobot.rb -f documentation --color failed>'
when /SystemExit/ then
	puts "HI"
else
	puts "ELSE"
end