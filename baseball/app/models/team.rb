class Team < ActiveRecord::Base
  set_table_name(:teams)
  set_primary_keys(:yearID, :lgID, :teamID)

  has_many :playerships, :foreign_key => [:yearID, :teamID],
    :primary_key => [:yearID, :teamID]

  has_many :persons, :through => :playerships

  has_many :managerships, :foreign_key => [:yearID, :teamID],
    :primary_key => [:yearID, :teamID]

end