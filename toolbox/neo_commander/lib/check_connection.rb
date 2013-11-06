#!/usr/bin/env ruby

require "net/http"

# -- check connection to Selenium RC
def check_connection
      one_wait = 5
      max_wait = 5
      request = Net::HTTP::Get.new('/')
      wait = 0;
      while (wait < max_wait)
          begin
              response = Net::HTTP.start(@url.host, @url.port) {|http|
                  http.request(request)
              }
              break if Net::HTTPForbidden === response
              break if Net::HTTPNotFound === response
              break if Net::HTTPSuccess === response
              # When we try to connect to a down server with an Apache proxy, 
              # we'll get Net::HTTPBadGateway and get here
          rescue Errno::ECONNREFUSED
              # When we try to connect to a down server without an Apache proxy, 
              # such as a dev instance, we'll get here
          end
          sleep one_wait;
          wait += one_wait
      end
      if (wait == max_wait)
          puts("-- ERROR: couldn't connect to test host on " + @url.host.to_s)
          return false
      end
      puts("-- SUCCESS: test host is alive !\n")
      return true
end

if ARGV.length < 1
   puts "-- usage: #{$0} test_host_url"
   exit(1)
end
@url = URI.parse(ARGV[0])
puts "-- host: " + @url.host.to_s
puts "-- port: " + @url.port.to_s

if (!check_connection)
   exit(1)
end
exit(0)
