require_relative 'contact'
require 'pry'
require 'active_record'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  def initialize
    ActiveRecord::Base.establish_connection(
      adapter: "postgresql",
      host: "localhost",
      database: "contact_list",
      username: 'development',
      password: 'development'
      )
  end

  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.

  def run(arguments)
    case arguments.shift
    when "all"
      Contact.all.order(:id).each do |contact|
        puts contact
      end
    when "create"
      puts "What is the person's full name?"
      new_name = STDIN.gets.chomp
      puts "What is their email?"
      new_email = STDIN.gets.chomp
      contact = Contact.create(name: new_name, email: new_email)
      puts "#{contact} has been added"
    when "update" 
      puts "What is the person's full name?"
      new_name = STDIN.gets.chomp
      puts "What is their email?"
      new_email = STDIN.gets.chomp
      contact = Contact.find(arguments.shift)
      contact.update(name: new_name, email: new_email)
      puts "Updated contact to #{contact}"
    when "find"
      puts contact = Contact.find(arguments.shift)
    when "delete"
      contact = Contact.find(arguments.shift)
      contact.destroy
      puts "#{contact} has been deleted"
    when "search"
      # How to use REGEX in SQL!
      puts Contact.where("name ~* :shift", shift: arguments.shift)
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