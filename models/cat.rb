require_relative '../lib/sql_object'

class Cat < SQLObject
  attr_reader :name, :owner

  belongs_to :user, foreign_key: :owner_id
  
  self.table_name = 'cats'
  self.finalize!
end
