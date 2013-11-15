require_relative "../../toolbox/ssh_commander/lib_commander"

sc = ShellCommander.new(:host => "10.10.9.129", :user => "admin", :password => "password")

puts "-- Starting BIZ Deployment --"
sc.exec("en")
sc.exec("password")
sc.exec("show version")