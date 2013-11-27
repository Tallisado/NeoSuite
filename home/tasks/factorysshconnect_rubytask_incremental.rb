require_relative "../../toolbox/ssh_commander/lib_commander"
sleep 780
sc = ShellCommander.new(:host => "10.10.9.165", :user => "admin", :password => "password")

puts "-- Check if box is online --"
#Enable
sc.exec("en")
#Enter password
sc.exec("password")
#show version
sc.exec("show version")