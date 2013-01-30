class HallOfFame < ActiveRecord::Base
  set_table_name(:hall_of_fame)
  set_primary_keys(:hofID, :yearID, :votedBy)
end