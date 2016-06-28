require 'csv'
require 'pry'


# Represents a person in an address book.
# The ContactList class will work with Contact objects instead of interacting with the CSV file directly
class Contact
  # @@ids = 0
  attr_accessor :name, :email, :id
  
  # Creates a new contact object
  # @param name [String] The contact's name
  # @param email [String] The contact's email address
  def initialize(name, email)
    @name = name
    @email = email
    @id = CSV.read('BC_contacts.csv').length + 1
    # TODO: Assign parameter values to instance variables.
  end

  # Formats the instances of a new contact nicely
  def format
    "#{self.id}: #{self.name} (#{self.email})"
  end

  # Provides functionality for managing contacts in the csv file.
  class << self

    # Opens 'contacts.csv' and creates a Contact object for each line in the file (aka each contact).
    # @return [Array<Contact>] Array of Contact objects
    def all
      bc_contacts = []
      CSV.foreach('BC_contacts.csv') do |row|
        bc_contacts << Contact.new(row[1], row[2]).format
      end
      bc_contacts
      # TODO: Return an Array of Contact instances made from the data in 'contacts.csv'.
    end

    # Creates a new contact, adding it to the csv file, returning the new contact.
    # @param name [String] the new contact's name
    # @param email [String] the contact's email
    def create(name, email)
      # Instantiates a Contact
      new_contact_array = []
      new_contact = Contact.new(name, email)
      new_contact_array << new_contact.id
      new_contact_array << new_contact.name
      new_contact_array << new_contact.email
      # add it's data to the contacts.csv file
      CSV.open('BC_contacts.csv', 'a+') do |csv|
        csv << new_contact_array
      end
      # Return value
      "added entry #{new_contact.format}."
      # TODO: Instantiate a Contact, add its data to the 'contacts.csv' file, and return it.
    end
    
    # Find the Contact in the 'contacts.csv' file with the matching id.
    # @param id [Integer] the contact id
    # @return [Contact, nil] the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      show = []
      CSV.foreach('BC_contacts.csv') do |row|
        show << Contact.new(row[1], row[2]).format if row[0] == id
      end
      show
      # TODO: Find the Contact in the 'contacts.csv' file with the matching id.
    end
    
    # Search for contacts by either name or email.
    # @param term [String] the name fragment or email fragment to search for
    # @return [Array<Contact>] Array of Contact objects.
    def search(term)
      search = []
      CSV.foreach('BC_contacts.csv') do |row|
        search << Contact.new(row[1], row[2]).format if row.to_s.match(/#{term}/)
      end
      search
      # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
    end

  end

end