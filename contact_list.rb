require_relative 'contact'
require 'pry'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.

  def run(arguments)
    case arguments.shift
    when "all"
      puts Contact.all
    when "create"
      puts "What is the person's full name?"
      new_name = STDIN.gets.chomp
      puts "What is their email?"
      new_email = STDIN.gets.chomp
      begin
        contact = Contact.create(new_name, new_email)
        puts "#{contact} has been added"
      rescue EmailExists => ex
        puts ex.message
      end
    when "update" 
      puts "What is the person's full name?"
      new_name = $stdin.gets.chomp
      puts "What is their email?"
      new_email = $stdin.gets.chomp
      the_contact = Contact.find(arguments.shift)
      the_contact.name = new_name
      the_contact.email = new_email
      the_contact.save
      puts "Updated contact to #{the_contact}"
    when "find"
      result = Contact.find(arguments.shift)
      puts result ? result : "No such contact"
    when "delete"
      the_contact = Contact.find(arguments.shift)
      if the_contact
        the_contact.destroy
        puts "Contact has been deleted"
      else
        puts "The contact cannot be found"
      end
    when "search"
      puts Contact.search(arguments.shift)
    else
      puts "Here is a list of available commands:"\
      "\n create - Create a new contact"\
      "\n all - List all contacts"\
      "\n find - Show a contact"\
      "\n search - Search contacts"\
      "\n update - Update a contact"\
      "\n delete - Delete a contact"
    end
  end
end

lets_go = ContactList.new
lets_go.run(ARGV)