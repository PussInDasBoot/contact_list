require 'pry'
require 'active_record'

class Contact < ActiveRecord::Base
  validates :email, uniqueness: true

  def to_s
    "#{id}: #{name} (#{email})"
  end
end