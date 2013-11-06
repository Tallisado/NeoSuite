require_relative "../../toolbox/ssh_commander/lib_commander"

sc = ShellCommander.new(:host => "10.10.9.129", :user => "admin", :password => "password")

puts "-- Starting BIZ Deployment --"
#outputs to screen
sc.exec("en")
#$captures to variable
sc.exec("password")
#sc.exec("copy tftp sdflash")
#Enter TFTP server to copy from
#sc.exec("10.10.9.156")
#Source path and file from TFTP server
#sc.exec("Neo\NEOA-amb_r6-36-D-E.biz")
#Destination file
#sc.exec("NEOA-amb_r6-36-D-E.biz")
