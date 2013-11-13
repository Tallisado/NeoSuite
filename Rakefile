# -- usage: rake help
#wget 'http://root:Password1@10.10.9.157/teamcity/httpAuth/action.html?add2Queue=NEOSanity_Nightly&name=BIZFILE&value=amb_abc.biz'
#wget 'http://root:Password1@10.10.9.157/teamcity/httpAuth/action.html?add2Queue=NEOSuite_Nightly&env.name=BIZ&env.value=amb_abc.biz'
#echo %dep.NeoSuiteNightly_Event.env.BIZ%

require "timeout"
require "fileutils"
require 'yaml'
require 'rake'
require './toolbox/neo_commander/lib/neo_helpermethods'

# -- first global
@profile 								= ENV['PROFILE'].nil? ? "tasklist.default" : ENV['PROFILE']
@suite_root							= File.expand_path "#{File.dirname(__FILE__)}"		
@suite_home							= "#{@suite_root}/home"
@suite_workspace				= "#{@suite_home}/workspace/" + Time.now.strftime("%Y_%m_%d_%H.%M.%S")
@suite_logs_dir					= "#{@suite_workspace}/logs/"
@suite_report_dir				= "#{@suite_workspace}/reports/"
@toolbox_tools					= ["neo_commander", "webrobot", "ssh_commander"]
@tool_path_lookup				= @toolbox_tools.each_with_object({}) { |v,h| h[v] = "#{@suite_root}/toolbox/#{v}" }
@neo_debug							= ENV["NC_DEBUG"].nil? ? false : true
@neo_bizfile            = ENV['BIZFILE'].nil? ? 'UNKNOWN' : ENV['BIZFILE']

################################
# STDOUT / STDERR / DEBUG
################################
def p(s) puts "-- #{Time.now.strftime('[%H:%M:%S]')} #{s}" end
#def p_d(s) puts "-D #{Time.now.strftime('[%H:%M:%S]')} #{s}" if @neo_debug == true end
def p_d(s) 
	puts "-D #{Time.now.strftime('[%H:%M:%S]')} #{s}" if ENV["NC_DEBUG"]
end

# -- global vars
task :default => [:run]
@taskchain                 	= []
@tasks_retried_counter 	= 0
@current_task 				 	= 0
@task_hash							= read_yaml_file(@suite_root+"/home/profiles/#{@profile}")

# -- global needed in classes
@reports_dir           	= ENV["REPORTS"].nil? ? @suite_report_dir : ENV["REPORTS"]
@logs_dir           		= ENV["LOGS"].nil? ? @suite_logs_dir : ENV["LOGS"]
@definition_yaml_hash		= read_yaml_file(toolpath("neo_commander")+"/lib/definitions.yml")

# -- the following vars control the behavior of running tests
#@task_types = {"ruby" => "RubyTask" , "WRTask"]

# -- global class data
@task_data = {
   'output_on'                => true,
   'test_retry'               => false,
   'test_exit_status_passed'  => "PASSED", 		#1 example, 0 failures
   'test_exit_status_failed'  => "FAILED",
   'test_exit_status_skipped' => "SKIPPED",
   'test_exit_status_error' 	=> "ERROR",
   'reports_dir'              => @reports_dir,
   'logs_dir'		              => @logs_dir,
   'xml_report_class_name'    => "qa.tasks",
   'xml_report_file_name'     => "report.xml",
	 'definitions'							=> @definition_yaml_hash,
	 'toolbox_tools'						=> @toolbox_tools,
	 'tool_path_lookup'					=> @tool_path_lookup,
	 'suite_root'								=> @suite_root
	 
}

require toolpath("neo_commander", @task_data['toolbox_tools'], @task_data['tool_path_lookup'])+"/lib/base_task"
require toolpath("neo_commander", @task_data['toolbox_tools'], @task_data['tool_path_lookup'])+"/lib/tasks"


# -- prepare reports_dir
def prepare_workspace_dir
   FileUtils.mkdir_p @logs_dir
   FileUtils.mkdir_p @reports_dir
	 #FileUtils.cp(toolpath("webrobot")+'/webrobot.rake', @suite_home)
	 #FileUtils.rm_r(@task_data['reports_dir']) if File.directory?(@task_data['reports_dir'])
   #FileUtils.mkdir_p(@task_data['reports_dir'])
end

def prepare_taskchain
	@taskchain = TaskChain.new()
	@task_hash.each do |task_name, task_yaml_hash|
		if task_name == "commander"
			@taskchain.set_chainname(task_yaml_hash)
		elsif task_name == "transpose"
			@taskchain.add_transpose(task_name, @task_data, task_yaml_hash)
		else
			@taskchain.add_task(task_name, @task_data, task_yaml_hash)
		end
	end
end

# -- run all tests
desc "-- run all tasks..."
task :run do
	puts "--- EXECUTING NEO COMMANDER ---"
	puts "--- [biz]       : " + @neo_bizfile
	puts "--- [debug]     : " + ((@neo_debug == false) ? "OFF" : "ON")
	puts "--- [profile]   : " + @profile
	puts "--- [logs]      : " + @logs_dir
	puts "--- [reports]   : " + @reports_dir
	puts "-------------------------------"

	#puts "running all the tasks"
	
	# -- first, let's setup/cleanup reports_dir
	prepare_workspace_dir
	
	# -- now, build the test toolchain from profile and task test files
	prepare_taskchain
	
	# -- let's run each test now
	@taskchain.execute_chain
	clean_exit
end

# -- print tests
desc "-- print tasks and show how they are loaded..."
task :show do
	prepare_taskchain
	@taskchain.show_chain
end

task :pull_into_home do
	Dir.chdir("/home/NeoSuite") do
		%x{git pull}
	end
end

task :copy_template_to_teamcity do
	puts "Teamplate interval:" + ENV['TEMPLATE_INTERVAL']
	Dir.chdir("/home/NeoSuite") do
		%x{rm /root/.BuildServer/config/_notifications/email/build_successful.ftl}
		%x{cp /home/NeoSuite/toolbox/etc/TeamCity/EmailTemplate/build_successful.ftl ~/.BuildServer/config/_notifications/email/build_successful.ftl}
		sleep(ENV['TEMPLATE_INTERVAL'].to_i)
	end
end

desc "-- show usage of Neo Commander"
task :help do
    puts "\n-- usage: \n\n"
    puts "   rake help                                                     : print this message"
    puts "   rake run PROFILE=tasklist.yaml                                : this will run tasks based on the profile"
    puts "   rake show PROFILE=tasklist.yaml                               : this will print descriptions of your tasks, based on the profile"
    puts "   rake run PROFILE=tasklist.yaml REPORTS_DIR=</path/to/reports> : this will set default reports dir and run all tests\n\n\n\n"
    puts "   Eg:\n\n   rake PROFILE=tasklist.yaml REPORTS_DIR=</path/to/reports>\n\n\n"
    puts "   Sample profiles for your tasklist (loc: tests/some_test.rb):\n\n"
		puts "   deploy_biz1: { "
		puts "    toolbox: rubyfile,"
		puts "     file: \"some_file.rb\","
		puts "     failover: die,"
		puts "     retry: no,"
		puts "     paramlist: [a=1,y=string of win,someshit=1234]"
		puts "   }\n\n"
		puts "   Task Control:"
		puts "     [toolbox:] rubyfile|webrobot"
		puts ""
		puts "   Task Creation:"
		puts "   [rake create:<toolbox>] NAME=filename.rb"
		puts "   -- rake create:webrobot NAME=my_new_file.rb"
		puts "   -- rake create:sshcommander NAME=my_new_file.rb"
		puts "   -- rake create:ruby NAME=my_new_file.rb"
end

namespace :create do
	task :webrobot do
		puts "[CREATE] Creating and formatting template - WebRobot"
		contents = "#DO NOT DELETE THE FOLLOWING LINE\n"
		contents += 'require File.join(File.dirname(__FILE__), "./../lib/helper")'
	end
	task :sshcommander do
		puts "[CREATE] Creating and formatting template - SSHCommander"
		puts "-- Creating sshcommander template"
	end	
	task :cmdline do
		puts "[CREATE] Creating and formatting template - RubyScript"
		puts "-- Creating cmdline template"
	end
end

# -- total by exit status
def all_by_exit_status(status)
	a = Array.new
	@taskchain.taskchain_array.each do |task|
		a << task if task.exit_status == status
  end
  return a
end

# -- what do we do on exit ?
def clean_exit
	tasks_passed     = all_by_exit_status(@task_data['test_exit_status_passed'])
	tasks_failed     = all_by_exit_status(@task_data['test_exit_status_failed'])
	tasks_skipped    = all_by_exit_status(@task_data['test_exit_status_skipped'])
	tasks_error    	 = all_by_exit_status(@task_data['test_exit_status_error'])
  @task_data.merge!({'execution_time' => @taskchain.execution_time, 'tasks_passed' => tasks_passed, 'tasks_failed' => tasks_failed, 'tasks_skipped' => tasks_skipped, 'tasks_error' => tasks_error})
  
	Publisher.new(@task_data).publish_reports	 
	
	puts("\n==> DONE\n\n")
  puts("[  :: [SESSION]\n")
	
	# Team City Result
  teamcity_result = tasks_failed.length == 0 && tasks_error.length == 0 ? "[TCRESULT]=SUCCESSFUL\n" : "[TCRESULT]=UNSUCCESSUL\n"
	puts teamcity_result

  printf("%-27s %s\n","[TC]   -- tests passed:", tasks_passed.length.to_s)
  printf("%-27s %s\n","[TC]   -- tests failed:", tasks_failed.length.to_s)
  printf("%-27s %s\n","[TC]   -- tests executed:",@taskchain.executed_tasks.to_s)
  printf("%-27s %s\n","[TC]   -- tests skipped:", tasks_skipped.length.to_s)
  printf("%-27s %s\n","[TC]   -- tests error:", tasks_error.length.to_s)
  printf("%-27s %.2f %s\n","[TC]   -- execution time:", @taskchain.execution_time, "secs")
	printf("       -- reports prepared  \t: #{@reports_dir}\n")
  printf("       -- logs prepared     \t: #{@logs_dir}\n")
	
	puts("[TC]  Tasklist :\n")
	@taskchain.get_tasknames.each do |taskname|
		puts("[TC]    \t{#{taskname}}\n")	
		@taskchain.taskchain_array.each do |task|
			task.examples.each do |example|
				puts("[TC]    \t\t[#{example}]\n")
			end
		end
	end

	if tasks_error.length > 0
		puts("\n\n==> STATUS: [ some tests failed - execution failed ]\n")
		exit(1)
	else
		exit(0)
	end
end

#
# ::: Publisher [ creating report files ] :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
class Publisher
   def initialize(test_data)
      @task_data = test_data
      @tests_total     = @task_data['tasks_passed'].length + @task_data['tasks_failed'].length + @task_data['tasks_skipped'].length
   end

   def write_file(file, data)
      File.open(file, 'w') {|f| f.write(data) }
   end

   def create_html_reports(status, tag)
      output  = "<html><body>\n\nTasks that #{tag}:<br><br><table><tr><td>test</td><td>time</td></tr><tr></tr>\n"
      @task_data[status].each { |t|
         output += "<tr><td><a href='../logs/#{t.taskname}.txt'>#{t.taskname}</a></td><td>#{t.task_execution_time}</td></tr>\n"
      }
      output += "</table></body></html>"
      write_file(@task_data['reports_dir'] + "/#{status}.html", output)
   end

  def publish_reports	  
		make_html
		#make_xml
		#make_plot
  end
	 
	def make_xml
		# -- create an xml file
		document  = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n"
		document += "<report>\n"
		document += "   <suite successes='#{@task_data['tasks_passed'].length}'"
		document += "   skipped='#{@task_data['tasks_skipped'].length}' failures='#{@task_data['tasks_failed'].length}'"
		document += "   time='#{@task_data['execution_time']}' name='NeoSuite' tests='#{@tests_total}'>\n"
		if @task_data['tasks_passed'].length > 0
			 @task_data['tasks_passed'].each  { |t|
					document += "   <task name='#{t.taskname}' classname='#{@task_data['xml_report_class_name']}' time='#{t.task_execution_time}'>\n"
					document += "      <passed message='Test Passed'><![CDATA[\n\n#{t.output}\n\n]]>\n       </passed>\n"
					document += "   </task>\n"
			 }
		end
		if @task_data['tasks_failed'].length > 0
			 @task_data['tasks_failed'].each  { |t|
					document += "   <task name='#{t.taskname}' classname='#{@task_data['xml_report_class_name']}' time='#{t.task_execution_time}'>\n"
					document += "      <error message='Test Failed'><![CDATA[\n\n#{t.output}\n\n]]>\n       </error>\n"
					document += "   </task>\n"
			 }
		end
		if @task_data['tasks_skipped'].length > 0
			 @task_data['tasks_skipped'].each  { |t|
					document += "   <task name='#{t.taskname}' classname='#{@task_data['xml_report_class_name']}' time='#{t.task_execution_time}'>\n"
					document += "      <skipped message='Test Skipped'><![CDATA[\n\n#{t.output}\n\n]]>\n       </skipped>\n"
					document += "   </task>\n"
			 }
		end
		document += "   </suite>\n"
		document += "</report>\n"
		# -- write XML report
		write_file(@task_data['reports_dir'] + "/" + @task_data['xml_report_file_name'], document)
	end
	def make_html
      # -- write HTML report
      totals  = "<html><body>\n\nTests: #{@tests_total.to_s}<br>\n"
      totals += "Tests Passed: <a href='tasks_passed.html'>#{@task_data['tasks_passed'].length.to_s}</a><br>\n"
      totals += "Tests Failed: <a href='tasks_failed.html'>#{@task_data['tasks_failed'].length.to_s}</a><br>\n"
      totals += "Tests Skipped: <a href='tasks_skipped.html'>#{@task_data['tasks_skipped'].length.to_s}</a><br>\n"
      totals += "Tests Error: <a href='tasks_error.html'>#{@task_data['tasks_error'].length.to_s}</a><br>\n"
      totals += "Execution time: #{@task_data['execution_time']}<br>\n</body></html>"
      write_file(@task_data['reports_dir'] + "/report.html", totals)
      # -- create individual html report files complete with test output
      create_html_reports("tasks_passed", "PASSED")
      create_html_reports("tasks_failed", "FAILED")
      create_html_reports("tasks_skipped", "were SKIPPED")
      create_html_reports("tasks_error", "had fatal ERRORs")
	end
	def make_plot
	  document  = "<webtester_plot>\n"
	  document += "<testcases>#{@task_data['testcases_total'].to_s}</testcases>\n"	  
	  document += "<t_passed>#{@task_data['testcases_passed'].to_s}</t_passed>\n"	  
	  document += "<verifications>#{@task_data['verifications'].to_s}</verifications>\n"
	  document += "<v_passed>#{@task_data['verifications_passed'].to_s}</v_passed>\n"
	  document += "</webtester_plot>\n"
	  write_file(@task_data['reports_dir'] + "/" + @task_data['xml_plot_file_name'], document)
	end
end
	
class TaskChain
	attr_accessor :die, :taskchain_array, :execution_time, :executed_tasks, :chainname
	def initialize()
		@current_chain_index = 0
		@taskchain_ended = false
		@taskchain_term = false
		@taskchain_array = Array.new
		@transpose_array = Array.new
		@execution_time = 0.0
		@executed_tasks = 0
	end
	
	def set_chainname(chainname)
		p "--chainname: #{chainname}"
		@taskchainname = chainname
	end
	
	def add_task(task_name, task_data, task_hash)
		if task_hash["toolbox"] == "webrobot"
			@taskchain_array.push(WRTask.new(task_name, task_data, task_hash))
		elsif task_hash["toolbox"] == "rubyfile"
			@taskchain_array.push(RubyTask.new(task_name, task_data, task_hash))
		elsif task_hash["toolbox"] == "cmdline"
			p "no task defined : cmdline"
		end
	end
	
	def add_transpose(task_name, task_hash, task_data)
		p_d "add transpose"
		if task_hash["toolbox"] == "wrtest"
			@transpose_array.push(RubyTask.new(task_name, task_data, task_hash))
		end
	end
	
	def apply_operational()
		raise "[ERROR] A task was nil that should have had a resulting exit_status!" if @taskchain_array[@current_chain_index].exit_status.nil?

		p_d "-Task(#{@taskchain_array[@current_chain_index].taskname}) exit_status: "+ @taskchain_array[@current_chain_index].exit_status
		
		@executed_tasks += 1
		@current_chain_index += 1
	end
	
	def show_chain
		@taskchain_array.each do |task|
			task.to_s
		end
	end
	
	def get_tasknames
		s = []
		@taskchain_array.each do |task|
			s.push(task.taskname)
		end
		return s
	end
	
	def execute_chain	
		@tStart = Time.now	
		until @taskchain_ended
			p_d "execute next link in chain"
			@taskchain_array[@current_chain_index].execute_base_task
			
			apply_operational()			
			
			@taskchain_ended = true if (@current_chain_index >= @taskchain_array.length || @taskchain_term) 
	
		end
		@tFinish = Time.now
		@execution_time = @tFinish - @tStart
	end		
end