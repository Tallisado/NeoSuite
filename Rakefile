# -- usage: rake help
# curl 'http://root:Password1@10.10.9.157/teamcity/httpAuth/action.html?add2Queue=NEOSuiteNightly_Event&env.name=BIZ&env.value=amb_abc.biz'
# NS_VCSID=109489 NS_BUILDID=444 rake email_p4_incremental
# rake PROFILE=dryrun.yml NC_DEBUG=t URL='http://10.10.9.129/Login/index.php'
# rake wrsolo FILE=ppm_preferences_webrobot.rb


require 'rake'
require "timeout"
require "fileutils"
require 'yaml'
require 'rake'
require './toolbox/neo_commander/lib/neo_helpermethods'
require 'selenium-webdriver'

################################
# STDOUT / STDERR / DEBUG
################################
def p(s) puts "-- #{Time.now.strftime('[%H:%M:%S]')} #{s}" end
def p_d(s)	puts "-D #{Time.now.strftime('[%H:%M:%S]')} #{s}" if ENV["NC_DEBUG"] end

# -- prepare reports_dir
def prepare_workspace_dir
   FileUtils.mkdir_p ENV["LOGS"]
   FileUtils.mkdir_p ENV["REPORTS"]
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

@suite_root							= File.expand_path "#{File.dirname(__FILE__)}"		
@suite_home							= "#{@suite_root}/home"
@suite_workspace				= "#{@suite_home}/workspace/" + Time.now.strftime("%Y_%m_%d_%H.%M.%S")
@suite_logs_dir					= "#{@suite_workspace}/logs/"
@suite_report_dir				= "#{@suite_workspace}/reports/"
@toolbox_tools					= ["neo_commander", "webrobot", "ssh_commander"]
@tool_path_lookup				= @toolbox_tools.each_with_object({}) { |v,h| h[v] = "#{@suite_root}/toolbox/#{v}" }
@neo_debug							= ENV["NC_DEBUG"].nil? ? false : true
@taskchain              = []
@tasks_retried_counter 	= 0
@current_task 				 	= 0

@definition_yaml_hash		= read_yaml_file(toolpath("neo_commander")+"/lib/definitions.yml")

# -- global class data
@task_data = {
	 'output_on'                		=> true,
	 'test_retry'               		=> false,
	 'test_exit_status_passed'  		=> "PASSED", 		#1 example, 0 failures
	 'test_exit_status_failed'  		=> "FAILED",
	 'test_exit_status_skipped' 		=> "SKIPPED",
	 'test_exit_status_error' 			=> "ERROR",
	 'test_exit_status_noelement' 	=> "NOELEMENT",
	 'reports_dir'              		=> ENV["REPORTS"],
	 'logs_dir'		              		=> ENV["LOGS"],
	 'xml_report_class_name' 				=> "qa.tasks",
	 'xml_report_file_name'  				=> "report.xml",
	 'configinfo_file_name'  				=> "configinfo.html",
	 'definitions'									=> @definition_yaml_hash,
	 'toolbox_tools'								=> @toolbox_tools,
	 'tool_path_lookup'							=> @tool_path_lookup,
	 'suite_root'										=> @suite_root
}

# -- TODO : figure out if --- create a suite to pass them to all tools/tasks
ENV["REPORTS"]         	= ENV["REPORTS"].nil? ? @suite_report_dir : ENV["REPORTS"]
ENV["LOGS"]          		= ENV["LOGS"].nil? ? @suite_logs_dir : ENV["LOGS"]

require toolpath("neo_commander", @task_data['toolbox_tools'], @task_data['tool_path_lookup'])+"/lib/base_task"
require toolpath("neo_commander", @task_data['toolbox_tools'], @task_data['tool_path_lookup'])+"/lib/tasks"
	
##########################
# RAKE: run (default)
# -- run all tests
##########################
task :default => [:run]
desc "-- run all tasks..."
task :run do
	# -- first global
	@profile 								= ENV['PROFILE'].nil? ? "tasklist.default" : ENV['PROFILE']
	@neo_bizfile            = ENV['BIZFILE'].nil? ? 'UNKNOWN' : ENV['BIZFILE']
	@task_hash							= read_yaml_file(@suite_root+"/home/profiles/#{@profile}")
	
	puts ""
	puts "--- EXECUTING NEO COMMANDER ---"
	puts "--- [biz]       : " + @neo_bizfile
	puts "--- [debug]     : " + ((@neo_debug == false) ? "OFF" : "ON")
	puts "--- [profile]   : " + @profile
	puts "--- [logs]      : " + ENV["LOGS"]
	puts "--- [reports]   : " + ENV["REPORTS"]
	
	puts "--- [rake url]  : " + (ENV["URL"].nil? ? "Task Based" : ENV["URL"])
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

##########################
# RAKE: wrsolo
# -- run target webrobot file
##########################
desc "run target webrobot file"
task :wrsolo do
	puts "wrsolo: " + ENV['FILE']
	filepath = File.join( File.dirname(__FILE__), "/home/tasks/#{ENV['FILE']}")
	if ENV['FILE'].nil? || !File.exist?(filepath)
		puts "FATAL: (URL) 'FILE' Cannot be missing from the ommand line when using wrsolo rake task. Please specifiy existing webrobot test using hte 'FILE=abc_webrobot.rb' environment variable!"
		puts filepath unless ENV['FILE'].nil?
		exit(1)
	end	
	@task_hash	= read_yaml_file(toolpath("neo_commander", @task_data['toolbox_tools'], @task_data['tool_path_lookup'])+"/lib/wr_solo.yml")
	prepare_workspace_dir
	prepare_taskchain
	@taskchain.execute_chain
	clean_exit
end

desc :wrsolo_fixtures do
	@app = Rake.application
	@app.init
	@app.add_import toolpath("webrobot", @task_data['toolbox_tools'], @task_data['tool_path_lookup'])+"/webrobot.rake"
	@app.load_imports
	Rake.application['vnc:start'].invoke()
end

##########################
# RAKE: wrsolo
##########################
desc "-- print tasks and show how they are loaded..."
task :show do
	prepare_taskchain
	@taskchain.show_chain
end

##########################
# RAKE: pull_into_home
##########################
desc "-- git pull from the suite_root directory"
task :pull_into_home do
	Dir.chdir(@suite_root) do
		%x{git pull}
	end
end

##########################
# RAKE: copy_template_to_teamcity
##########################
desc "-- copies the template for the teamcity resulting notification email"
task :copy_template_to_teamcity do
	puts "Teamplate interval:" + ENV['TEMPLATE_INTERVAL']
	Dir.chdir(@suite_root) do
		%x{rm /root/.BuildServer/config/_notifications/email/build_successful.ftl}
		%x{cp #{@suite_root}/toolbox/etc/TeamCity/CustomNotificationEmail/build_successful.ftl ~/.BuildServer/config/_notifications/email/build_successful.ftl}
		sleep(ENV['TEMPLATE_INTERVAL'].to_i)
	end
end

##########################
# RAKE: email_p4_incremental
##########################
#neosuite\toolbox\etc\TeamCity\IncrementalAssets
desc "-- sendmail : incremental"
task :email_p4_incremental do
	
	# -- set p4 home for our p4cmdline tool
	puts "@suite_root: " + @suite_root 
	puts "VCS ID:" + ENV['NS_VCSID']
	puts "BUILD ID:" + ENV['NS_BUILDID']
	ENV['P4CONFIG']='/home/.p4config'
	
	buildresults_fullpath = "#{@suite_root}/toolbox/etc/TeamCity/IncrementalAssets/incremental_buildresults.log"
	rest_buildlog_byid = "http://root:Password1@10.10.9.157/teamcity/httpAuth/downloadBuildLog.html?buildId=#{ENV['NS_BUILDID']}"
		
	# -- wget buildresults and parse them for results
	%x{wget -O #{buildresults_fullpath} #{rest_buildlog_byid}}		
	file = File.new("#{buildresults_fullpath}", "r")
	match = ""
	while (line = file.gets)
			match = line if line.include? '[TCRESULT]' #[TCRESULT]=SUCCESSFU
	end
	pass = match.include?('SUCCESSFUL') ? true : false

	# -- grab p4 data on user, parsing all required fields	
	full_p4_changeinfo = %x{p4 changes -m 1 @#{ENV['NS_VCSID']}}
	description = full_p4_changeinfo.split('\'')[1]
	description_long = %x{p4 changes -l -m 1 @#{ENV['NS_VCSID']}}
	username_and_workspace = %x{p4 changes -m 1 @#{ENV['NS_VCSID']} | awk '{ print $6 }'}
	username = username_and_workspace.split('@')[0]
	email = %x{p4 users -m 1 #{username} | awk '{print $2}'}.gsub!(/[<>]/, '')
		
	# -- paths to the files we will use	
	orig_audit_fullpath = "#{@suite_root}/toolbox/etc/TeamCity/IncrementalAssets/incremental_audit_original.html"
	mod_audit_fullpath = "#{@suite_root}/toolbox/etc/TeamCity/IncrementalAssets/incremental_audit_mod.html"
		
	puts "PASS: " + pass.to_s
	puts "EMAIL: " + email
	puts "DESC: " + description
	puts "DESCLONG: " + description_long		
	puts "orig_audit_fullpath: " + orig_audit_fullpath
	puts "mod_audit_fullpath: " + mod_audit_fullpath
	
	# -- using the template, we modify it with the new results
	text = File.read(orig_audit_fullpath)
	text.gsub!('NAME', username_and_workspace)
	text.gsub!(/(RESULT)/, pass == true ? "PASSED" : "FAILED")
	text.gsub!(/(DESCRIPTION)/, description_long)
	File.open(mod_audit_fullpath, 'w+') {|f| f.write(text) }
		
	# -- send the email to the p4 user
	%x{( echo 'Subject: <P4 Commit>'; echo 'From: dvt-automation@adtran.com'; echo "MIME-Version: 1.0"; echo "Content-Type: text/html"; echo "Content-Disposition: inline"; cat #{mod_audit_fullpath}; ) | sendmail tallis.vanek@adtran.com}
	#%x{( echo 'Subject: <P4 Commit>'; echo 'From: dvt-automation@adtran.com'; echo "MIME-Version: 1.0"; echo "Content-Type: text/html"; echo "Content-Disposition: inline"; cat mod_audit_fullpath; ) | sendmail email}
	
	# -- delete the modified file and the build results we pulled
	File.delete(mod_audit_fullpath)
	#File.delete(buildresults_fullpath)
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
	noelement_error	 = all_by_exit_status(@task_data['test_exit_status_noelement'])
  @task_data.merge!({'execution_time' => @taskchain.execution_time, 'tasks_passed' => tasks_passed, 'tasks_failed' => tasks_failed, 'tasks_skipped' => tasks_skipped, 'tasks_error' => tasks_error, 'test_exit_status_noelement' => noelement_error })
  
	Publisher.new(@task_data).publish_reports	 
	
	puts("\n==> DONE\n\n")
  puts("[  :: [SESSION]\n")
	
	# Team City Result
  teamcity_result = tasks_failed.length == 0 && tasks_error.length == 0 && noelement_error.length == 0 ? "[TCRESULT]=SUCCESSFUL\n" : "[TCRESULT]=UNSUCCESSUL\n"
	puts teamcity_result

	puts("[TC] Target BIZ File : [#{@neo_bizfile}]")
  printf("%-27s %s\n","[TC]   -- tests passed:", tasks_passed.length.to_s)
  printf("%-27s %s\n","[TC]   -- tests failed:", tasks_failed.length.to_s)
  printf("%-27s %s\n","[TC]   -- tests executed:",@taskchain.executed_tasks.to_s)
  printf("%-27s %s\n","[TC]   -- tests skipped:", tasks_skipped.length.to_s)
  printf("%-27s %s\n","[TC]   -- tests error:", tasks_error.length.to_s)
  printf("%-27s %s\n","[TC]   -- tests no element:", noelement_error.length.to_s)
  printf("%-27s %.2f %s\n","[TC]   -- execution time:", @taskchain.execution_time, "secs")
	printf("       -- reports prepared  \t: #{ENV["reports"]}\n")
  printf("       -- logs prepared     \t: #{ENV["LOGS"]}\n")
	
	puts("[TC]  Tasklist :\n")		
	@taskchain.taskchain_array.each do |task|
		puts("[TC]    \t{#{task.taskname}}\n")			
		task.examples.each do |ex|
			puts("[TC]    \t\t[#{ex}  ]\n")
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
      write_file(ENV["REPORTS"] + "#{status}.html", output)
   end

  def publish_reports	  
		make_html
		make_configinfo
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
		write_file(ENV["REPORTS"] + @task_data['xml_report_file_name'], document)
	end
	def make_html
      # -- write HTML report
      totals  = "<html><body>\n\nTests: #{@tests_total.to_s}<br>\n"
      totals += "Tests Passed: <a href='tasks_passed.html'>#{@task_data['tasks_passed'].length.to_s}</a><br>\n"
      totals += "Tests Failed: <a href='tasks_failed.html'>#{@task_data['tasks_failed'].length.to_s}</a><br>\n"
      totals += "Tests Skipped: <a href='tasks_skipped.html'>#{@task_data['tasks_skipped'].length.to_s}</a><br>\n"
      totals += "Tests Error: <a href='tasks_error.html'>#{@task_data['tasks_error'].length.to_s}</a><br>\n"
      totals += "Execution time: #{@task_data['execution_time']}<br>\n"
      totals += "<br><br><a href=#{@task_data['configinfo_file_name']}>Configuration Infoormation</a><br>\n</body></html>"
      write_file(ENV["REPORTS"] + "report.html", totals)
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
	  write_file(ENV["REPORTS"] + @task_data['xml_plot_file_name'], document)
	end
	
	def make_configinfo
		document  = "<html><body>\n\n This document details the configuration information specific to its execution<br><br>\n"
		a = $LOADED_FEATURES.
		 select { |feature| feature.include? 'gems' }.
		 map { |feature| File.dirname(feature) }.
		 map { |feature| feature.split('/')[-3] }.
		 uniq.sort.to_s
		document += "<p> #{a} </p><br><br>"
		document += "<br>\n</body></html>"
		write_file(ENV["REPORTS"] + @task_data['configinfo_file_name'], document)
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