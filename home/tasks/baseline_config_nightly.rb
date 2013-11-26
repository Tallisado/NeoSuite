require_relative "../../toolbox/ssh_commander/lib_commander"

sc = ShellCommander.new(:host => "10.10.9.129", :user => "admin", :password => "password")

puts "-- Starting configuration reset --"
#Enable
sc.exec("en")
#Enter password
sc.exec("password")
# #Erase config
# sc.exec("erase startup-config")
# sc.exec("y")
# #Factory default unit
# sc.exec("factory-default")
# #Confirm factory default
# sc.exec("y")
# #issue copy from tftp command to push our baseline config
# sc.exec("copy tftp startup-config")
# #Enter TFTP server to copy from
# sc.exec("10.10.9.156")
# #Source path and file from TFTP server
# sc.exec("config/neo_default.cfg")
# #Reload unit
# sc.exec_raw("reload")
# sc.exec("n")
# sc.exec("y")
sleep 60