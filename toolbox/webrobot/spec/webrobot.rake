require 'rspec/core/rake_task'

desc 'Default: run tests against the selenium driver on the local machine (components should be currently running)'
namespace :test do
  RSpec::Core::RakeTask.new(:sauce) do |t|		
		# opt
		t.pattern = ENV["FILE"].nil? ? ["./**/*_test.rb","./*_test.rb"] : ENV["FILE"]
		t.rspec_opts = ['-f html', '-o results.html', '--color']
		t.verbose = true
  end
end