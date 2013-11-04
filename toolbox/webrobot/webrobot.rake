require 'rspec/core/rake_task'

desc 'Default: run tests against the selenium driver on the local machine (components should be currently running)'
namespace :for do
	task :real do |t|
		puts "RUNNING REALLLL WEBROBOT RAKE"
	end
end
