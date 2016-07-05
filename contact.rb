require 'pry'
require 'pg'

TABLE_NAME = "contacts"
# Represents a person in an address book.
class Contact
  attr_accessor :name, :email
  attr_reader :id
  
  # Creates a new contact object
  # @param['string'] is accessing the corresponding value of the 'string' key in the hash of a row of contacts table
  def initialize(name, email, id = nil)
    @name = name
    @email = email
    @id = id
  end

  @@conn = nil
  @@from_hash_lambda = lambda { |row| Contact.new(row['name'], row['email'], row['id']) }

  # Formats the instances of a new contact nicely
  def to_s
    "#{id}: #{name} (#{email})"
  end

  def self.connection
      @@conn = @@conn || PG.connect(
        dbname: 'contact_list'
      )
  end 

  # Connects to local database and returns all entries in contact table
  def self.all
    res = self.connection.exec_params(
      "SELECT * 
      FROM #{TABLE_NAME}
      ORDER BY id;")
    res.map &@@from_hash_lambda
  end

  # Creates a new contact
  def self.create(name, email)
    a = Contact.new(name, email)
    a.save
    a
  end
  # Finds a contact based on their id
  def self.find(id)
    result = self.connection.exec_params(
      "SELECT * 
      FROM #{TABLE_NAME} 
      WHERE id = $1::int;", [id])
    result = result[0]
    if result
      Contact.new(result['name'], result['email'], result['id'])
    end
  end
  
  # Should return any contacts that include a search term
  def self.search(term)
    result = self.connection.exec_params(
      "SELECT * 
      FROM #{TABLE_NAME} 
      WHERE name LIKE '%' || $1 || '%';", [term])
    result.map &@@from_hash_lambda
  end

  def save
    if id #UPDATE
      self.class.connection.exec_params(
        "UPDATE #{TABLE_NAME} 
        SET name = $1, email = $2 
        WHERE id =$3::int;", [name, email, id])
    elsif self.class.connection.exec_params(
        "SELECT * 
        FROM #{TABLE_NAME} 
        WHERE email = $1;", [email]).ntuples > 0
      raise EmailExists, 'Email already exists, try unique email'
    else
      res = self.class.connection.exec_params(
        "INSERT INTO #{TABLE_NAME}
        (name, email) 
        VALUES ($1, $2) 
        RETURNING id;", [name, email])
      @id = res[0]['id'].to_i
    end
  end

  def destroy
    self.class.connection.exec_params(
      "DELETE FROM #{TABLE_NAME} 
      WHERE id = $1::int;", [id])
  end

end

class EmailExists < StandardError
end