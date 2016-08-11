require_relative '../../lib/active_record_lite/sql_object'

class CatRentalRequest < SQLObject
  belongs_to :cat
  belongs_to :user

  self.table_name = 'cat_rental_requests'
  self.finalize!
end
