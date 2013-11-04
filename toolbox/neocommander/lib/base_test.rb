#!/usr/bin/env ruby
require_relative './../lib/ruby_suite'

class YamlReader
	@CONFIG	
	def initialize(file)
		if File.exist?(file)
			@CONFIG = YAML::load(File.read(file))
		else
			raise "-- ERROR: config YAML file doesn't exist: " + file
		end
	end
	
	def get_setup
	end
	
	def show
		puts @CONFIG
	end	
end

class BaseTest
    attr_accessor :suite, :passed
    def initialize
       @suite  = RubySuite.new(:test_name => self.class.name)
       @passed = false
    end

    # -- test begins
    def run_test
       begin
          setup
          run_main
          @passed = true
       rescue => e
          @suite.p "FAILED: "
          @suite.p e.inspect
          @suite.p e.backtrace
		  @suite.p $!
		  #@suite.p "----------------------PAGE SOURCE---------------------"
		  #@suite.p @suite.selenium.page_source
		  #@suite.p "----------------------PAGE SOURCE---------------------"
		  @passed = false
       ensure
          teardown
          @suite.clean_exit(@passed)
       end
    end

    # def save_screenshot filename=nil
      # @suite.p "CAPTURE SCREENSHOT"
      # begin
        # screenshot_flag = true
        # filename = (ENV['REPORT_FILE'] + '.png') unless filename
        # screenshot = @suite.selenium.capture_screenshot_to_string()
        # tmp_file = File.open(filename,'w')
        # tmp_file.puts(Base64.decode64(screenshot))
        # tmp_file.close()
        # @suite.p "SCREENSHOT CAPTURED TO #{filename}"
        # screenshot_flag = false
        # screenshot = @suite.selenium.capture_entire_page_screenshot_to_string()
        # tmp_file = File.open(filename,'w')
        # tmp_file.puts(Base64.decode64(screenshot))
        # tmp_file.close()
        # @suite.p "ENTIRE SCREENSHOT CAPTURED TO #{filename}"
     # rescue => e
        # if screenshot_flag
           # @suite.p "FAILED TO CAPTURE SCREENSHOT: "
           # @suite.p e.inspect
           # @suite.p e.backtrace
        # end
      # end
    # end

    # -- this method is overriden in subclass
    def run_main
    end

    # -- this method is overriden in subclass
    def setup
       @suite.p "\n:: [SETUP]\n"
       # -- let's print the description of each test first:
       Dir.glob("#{@suite.suite_root}/tests/**/*_test.rb") { |f|
		  #File.open(infile, "r:ASCII-8BIT") do |f|
          #file_contents = f.read 
          file_contents = File.read(f, col_sep: "$", encoding: "ISO8859-1")
          @suite.p "\n   [description] : " + /^#.*@description(.*$)/.match(file_contents)[0].gsub(/^#.*@description/, '') + "\n" if /#{self.class.name}/.match(file_contents)
		  #end
       }
    end

    # -- this method is overriden in subclass
    def teardown
       @suite.p "\n:: [TEARDOWN]\n"
    end
end
