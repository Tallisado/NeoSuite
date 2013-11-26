require_relative "../../toolbox/ssh_commander/lib_commander"

sc = ShellCommander.new(:host => "10.10.9.129", :user => "admin", :password => "password")

puts "-- Starting configuration reset --"
#Enable
sc.exec("en")
#Enter password
sc.exec("password")
#show version
sc.exec("show version")