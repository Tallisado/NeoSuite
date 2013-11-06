  one_wait = 5
  max_wait = 15
  request = Net::HTTP::Get.new('/selenium-server/')
  wait = 0;
  while (wait < max_wait)
	  begin
		  response = Net::HTTP.start(@host, @port) {|http|
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
	  p("-- ERROR: couldn't connect to Selenium RC on " + @host)
	  return false
  end
  return true