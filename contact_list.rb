require_relative 'contact'
require 'pry'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.

  def run
    puts "Here is a list of available commands:"\
    "\n new - Create a new contact"\
    "\n list - List all contacts"\
    "\n show - Show a contact"\
    "\n search - Search contacts"
    if ARGV[0] == "list"
      puts Contact.all
    end

    if ARGV[0] == "new"
      puts "What is the person's full name?"
      new_name = $stdin.gets.chomp
      puts "What is their email?"
      new_email = $stdin.gets.chomp
      puts Contact.create(new_name, new_email)
    end
    if ARGV[0] == "show"
      puts Contact.find(ARGV[1])
    end
    if ARGV[0] == "search"
      puts Contact.search(ARGV[1])
    end
  end
end

lets_go = ContactList.new
lets_go.run