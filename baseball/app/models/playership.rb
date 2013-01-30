class Playership <ActiveRecord::Base
  set_table_name(:appearances)
  set_primary_keys(:yearID, :teamID, :playerID)

  belongs_to :person, :foreign_key => :playerID,
  :primary_key => :playerID
  belongs_to :team, :foreign_key => [:yearID, :teamID],
    :primary_key => [:yearID, :teamID]
end