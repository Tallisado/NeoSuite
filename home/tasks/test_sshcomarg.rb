require_relative "../../toolbox/ssh_commander/lib_commander"

puts ShellCommander.args?
puts ShellCommander.get_arg_string
puts ShellCommander.get_arg('server')
puts ShellCommander.get_arg('enpassword')