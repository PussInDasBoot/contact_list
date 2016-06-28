require_relative 'contact'
require 'pry'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.

  def run(arguments)
    case arguments.shift
    when "list"
      puts Contact.all
    when "new"
      puts "What is the person's full name?"
      new_name = $stdin.gets.chomp
      puts "What is their email?"
      new_email = $stdin.gets.chomp
      puts Contact.create(new_name, new_email)
    when "show"
      puts Contact.find(arguments.shift)
    when "search"
      puts Contact.search(arguments.shift)
    else
      puts "Here is a list of available commands:"\
      "\n new - Create a new contact"\
      "\n list - List all contacts"\
      "\n show - Show a contact"\
      "\n search - Search contacts"
    end
  end
end

lets_go = ContactList.new
lets_go.run(ARGV)