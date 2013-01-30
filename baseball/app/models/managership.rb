class Managership < ActiveRecord::Base
  set_table_name(:managers)
  set_primary_keys(:managerID, :yearID, :teamID, :inseason)

  belongs_to :person

  belongs_to :team, :foreign_key => [:yearID, :lgID, :teamID]
end