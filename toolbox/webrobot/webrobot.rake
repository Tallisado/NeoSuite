require 'rspec/core/rake_task'

desc 'Default: run tests against the selenium driver on the local machine (components should be currently running)'
namespace :spec do
	task :ipass do |t|
		puts "1 example, 0 failures"
	end
end

namespace :spec do
	task :ifail do |t|
		puts "1 example, 1 failures"
	end
end
