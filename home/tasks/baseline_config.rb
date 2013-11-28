require_relative "../../toolbox/ssh_commander/lib_commander"

puts ShellCommander.get_arg_string

sc = ShellCommander.new
sc.open_telnet(:host => ShellCommander.get_arg('server'), :user => ShellCommander.get_arg('user'), :password => ShellCommander.get_arg('password'), :retry_timeout => 10)
puts "** Starting configuration reset **"
#Enable
sc.exec("en")
#Enter password
sc.exec(ShellCommander.get_arg('enpassword'))
#Erase config
sc.exec("erase startup-config")
sc.exec("y")
#Factory default unit
sc.exec("factory-default")
#Confirm factory default
sc.exec("y")
#issue copy from tftp command to push our baseline config
sc.exec("copy tftp startup-config")
#Enter TFTP server to copy from
sc.exec(ShellCommander.get_arg('tftpserver'))
#Source path and file from TFTP server
sc.exec(ShellCommander.get_arg('config'))
#Reload unit
sc.exec_raw("reload")
sleep 30
sc.open_telnet!(:host => ShellCommander.get_arg('server'), :user => ShellCommander.get_arg('user'), :password => ShellCommander.get_arg('password'), :retry_timeout => 315)


## notes
## this will loop until either the retry is hit, or connection established - timeout error is : ShellCommander:Connect has timed out (RuntimeError)
###sc.open_telnet!(:host => "10.10.9.165", :user => "admin", :password => "password", :retry_timeout => 10)
## this will execute once, and then go to the next line -- even if fail
###sc.open_telnet(:host => "10.10.9.165", :user => "admin", :password => "password")
## you can check to see if the above line connected using 'sc.isconnected?', which returns a boolean