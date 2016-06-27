require_relative 'contact'
require 'pry'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.
  puts "Here is a list of available commands:"\
  "\n new - Create a new contact"\
  "\n list - List all contacts"\
  "\n show - Show a contact"\
  "\n search - Search contacts"


  if ARGV[0] == "list"
    puts Contact.all
  end

  if ARGV[0] == "new"
    puts Contact.create
  end
end